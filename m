From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Mon, 14 Mar 2016 12:27:01 +0800
Subject: [PATCH v3 net-next 0/2] net: hns: get and set RSS indirection
 table by using ethtool
In-Reply-To: <1457686918.1347.56.camel@linux.intel.com>
References: <1457666747-244953-1-git-send-email-yankejian@huawei.com>
 <1457686918.1347.56.camel@linux.intel.com>
Message-ID: <56E63D95.6080702@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/11 17:01, Andy Shevchenko wrote:
> On Fri, 2016-03-11 at 11:25 +0800, Kejian Yan wrote:
>> When we use ethtool to retrieves or configure the receive flow hash 
>> indirection table, ethtool needs to call .get_rxnfc to get the ring
>> number
>> so this patchset implements the .get_rxnfc and fixes the bug that we
>> can
>> not get the tatal table each time.
>>
> FWIW:
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hi Andy,
I'm sorry for missing it.i will fix it in next submit.

MBR, Kejian

>> ---
>> change log:
>> PATCH v3:
>>  - This patchset fixes the building warning and error
>>
>> PATCH v2:
>>  - This patchset fixes the comments provided by Andy Shevchenko <Andy
>> Shevchenko>
>>
>> PATCH v1:
>>  - first submit
>>
>> Kejian Yan (2):
>>   net: hns: fix return value of the function about rss
>>   net: hns: fixes a bug of RSS
>>
>>  drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c |  8 ++++---
>>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c |  2 +-
>>  drivers/net/ethernet/hisilicon/hns/hns_ethtool.c  | 28
>> ++++++++++++++++-------
>>  3 files changed, 26 insertions(+), 12 deletions(-)
>>
