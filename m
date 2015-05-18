From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 18 May 2015 15:03:33 +0200
Subject: [PATCH v6 11/25] iommu: exynos: add support for binding more than
 one sysmmu to master device
In-Reply-To: <20150510223437.b651f6d2f3f0ead49eb72488@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-12-git-send-email-m.szyprowski@samsung.com>
 <20150510223437.b651f6d2f3f0ead49eb72488@samsung.com>
Message-ID: <5559E325.2060106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-05-10 15:34, Cho KyongHo wrote:
> On Mon, 04 May 2015 10:16:06 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
>> This patch adds support for assigning more than one SYSMMU controller to
>> the master device. This has been achieved simply by chaning the struct
>> device pointer in struct exynos_iommu_owner into the list of struct
>> sysmmu_drvdata of all controllers assigned to the given master device.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/iommu/exynos-iommu.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index f2eceb6605c5..598660c87410 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -186,7 +186,7 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
>>   
>>   /* attached to dev.archdata.iommu of the master device */
>>   struct exynos_iommu_owner {
>> -	struct device *sysmmu;
>> +	struct list_head clients;
> 'clients' is the list of System MMUs that are assigned to the same iommu
> domain. I don't think clients is not a good list name for exynos_iommu_owner
> even though the elements are the same because they are used in different
> contexts.

Okay, I will rename it to 'controllers' then.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
