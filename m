From: thunder.leizhen@huawei.com (leizhen)
Date: Tue, 30 Jun 2015 16:57:33 +0800
Subject: [PATCH 7/8] iommu/arm-smmu: enlarge STRTAB_L1_SZ_SHIFT to support
 larger sidsize
In-Reply-To: <20150629173539.GM17474@arm.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
 <1435307584-9812-8-git-send-email-thunder.leizhen@huawei.com>
 <20150629173539.GM17474@arm.com>
Message-ID: <559259FD.6070000@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/6/30 1:35, Will Deacon wrote:
> On Fri, Jun 26, 2015 at 09:33:03AM +0100, Zhen Lei wrote:
>> Because we will choose the minimum value between STRTAB_L1_SZ_SHIFT and
>> IDR1.SIDSIZE, so enlarge STRTAB_L1_SZ_SHIFT will not impact the platforms
>> whose IDR1.SIDSIZE is smaller than old STRTAB_L1_SZ_SHIFT value.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 87c3d9b..d799feb 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -206,7 +206,7 @@
>>   * Linear: Enough to cover 1 << IDR1.SIDSIZE entries
>>   * 2lvl: 8k L1 entries, 256 lazy entries per table (each table covers a PCI bus)
>>   */
>> -#define STRTAB_L1_SZ_SHIFT		16
>> +#define STRTAB_L1_SZ_SHIFT		20
>>  #define STRTAB_SPLIT			8
>>
>>  #define STRTAB_L1_DESC_DWORDS		1
> 
> Can you update the comment too, please, to say that we now have 128k entries
> at level 1?

OK, no problem.

> 
> Will
> 
> .
> 
