From: huangdaode@hisilicon.com (Daode Huang)
Date: Fri, 11 Mar 2016 09:58:41 +0800
Subject: [PATCH net 4/6] net: hns: adds uc match for debug port
In-Reply-To: <56D99007.6090804@cogentembedded.com>
References: <1457053798-93513-1-git-send-email-huangdaode@hisilicon.com>
 <1457053798-93513-5-git-send-email-huangdaode@hisilicon.com>
 <56D99007.6090804@cogentembedded.com>
Message-ID: <56E22651.3030903@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/4 21:39, Sergei Shtylyov wrote:
> On 3/4/2016 4:09 AM, Daode Huang wrote:
>
>> This patch adds uc match for debug port by:
>> 1)Enables uc match of debug port when initializing gmac
>> 2)Enables uc match of mac address register2
>>
>> Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
>> Signed-off-by: lipeng <lipeng321@huawei.com>
>
Lipeng is his full name. i will change it to another style (Peng Li 
<lipeng321@huawei.com>)

>    True/full name is required here.
>
>> ---
>>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c | 18 
>> +++++++++++++++++-
>>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  2 ++
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c 
>> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
>> index b8517b0..2591a51 100644
>> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
>> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> [...]
>> @@ -407,8 +419,12 @@ static void hns_gmac_set_mac_addr(void *mac_drv, 
>> char *mac_addr)
>>
>>           u32 low_val = mac_addr[5] | (mac_addr[4] << 8)
>>               | (mac_addr[3] << 16) | (mac_addr[2] << 24);
>> +
>> +        u32 val = dsaf_read_dev(drv, GMAC_STATION_ADDR_HIGH_2_REG);
>> +        u32 sta_addr_en = dsaf_get_bit(val, GMAC_ADDR_EN_B);
>
>    Empty line needed after declarations.
>

agree,
thanks
Daode.

>>           dsaf_write_dev(drv, GMAC_STATION_ADDR_LOW_2_REG, low_val);
>> -        dsaf_write_dev(drv, GMAC_STATION_ADDR_HIGH_2_REG, high_val);
>> +        dsaf_write_dev(drv, GMAC_STATION_ADDR_HIGH_2_REG,
>> +                   high_val | (sta_addr_en << GMAC_ADDR_EN_B));
>>       }
>>   }
>>
> [...]
>
> MBR, Sergei
>
>
> .
>
