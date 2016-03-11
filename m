From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 11 Mar 2016 16:29:29 +0300
Subject: [PATCH net 3/6] net: hns: fixed portid bug in sending manage pkt
In-Reply-To: <56E2251D.905@hisilicon.com>
References: <1457053798-93513-1-git-send-email-huangdaode@hisilicon.com>
 <1457053798-93513-4-git-send-email-huangdaode@hisilicon.com>
 <56D98F8F.5010700@cogentembedded.com> <56E2251D.905@hisilicon.com>
Message-ID: <56E2C839.4000700@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/11/2016 4:53 AM, Daode Huang wrote:

>>> In V2 chip, when sending mamagement packets, the driver should
>>> config the port id to BD descs.
>>>
>>> Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
>>> Signed-off-by: Lisheng <lisheng011@huawei.com>
>>> ---
>>>   drivers/net/ethernet/hisilicon/hns/hnae.h         | 3 +++
>>>   drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c | 1 +
>>>   drivers/net/ethernet/hisilicon/hns/hns_enet.c     | 4 ++++
>>>   3 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h
>>> b/drivers/net/ethernet/hisilicon/hns/hnae.h
>>> index 1cbcb9f..11a3f97 100644
>>> --- a/drivers/net/ethernet/hisilicon/hns/hnae.h
>>> +++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
>> [...]
>>> @@ -516,6 +518,7 @@ struct hnae_handle {
>>>       int q_num;
>>>       int vf_id;
>>>       u32 eport_id;
>>> +    u32 dport_id;    /*v2 tx bd should fill the dport_id*/
>>
>>    Please add spaces after /* and before */ (like it's done in other places
>> in this driver).
>>
>
> Hi MBR, Sergei,

    Just in case: MBR stands for "my best regards", Sergei is my name. :-)

> Daode.

MBR, Sergei
