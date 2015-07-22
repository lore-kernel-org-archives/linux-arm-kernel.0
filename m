From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 22 Jul 2015 11:00:16 +0800
Subject: [PATCH v3 0/5] iommu/arm-smmu: add support for non-pci devices
In-Reply-To: <55AE1F2F.3090106@arm.com>
References: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
 <55AE1F2F.3090106@arm.com>
Message-ID: <55AF0740.3070508@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/7/21 18:30, Robin Murphy wrote:
> On 21/07/15 08:30, Zhen Lei wrote:
>> Changelog:
>> v2 -> v3:
>> 1. add support for pci device hotplug, which missed in patch v2.
>> 2. only support #iommu-cells = <1>, add corresponding description in arm,smmu-v3.txt.
>> 3. add function find_smmu_by_device which extracted from find_smmu_by_node, to resolve
>>     the problem mentioned by Robin Murphy in [PATCH v2 7/9].
>>     Additionally:
>>     +    platform_set_drvdata(pdev, smmu);       //Patch v2
>>     +    dev->archdata.iommu = smmu;             //Patch v3, dev = &pdev->dev
> 
> 
> I didn't give any Reviewed-by tags, much less to revised patches that I've not even looked at yet; please see section 13 of Documentation/SubmittingPatches for what the Reviewed-by tag means.

OK. I see that now. So that Reviewed-by tags should always be given by the reviewer.

I initially thought that "Reviewed-by" should be added for who had reviewed the patch.

> 
> Robin.
> 
>>
>> v1 -> v2:
>> update the implementation of patch 1/9 according to Will Deacon's suggestion.
>> update the comment of patch 3/9 and 4/9.
>> use arm_smmu_options to skip the execution of command CMD_PREFETCH_CONFIG, see patch 5/9.
>> patch 6/9 is base on Laurent's series, to support probe deferral.
>> patch 7/9 according to Robin Murphy's suggestion, remove global variable arm_smmu_devices, thanks.
>> patch 9/9 add support for a master with multiple stream IDs.
>>
>> Zhen Lei (5):
>>    iommu/arm-smmu: to support probe deferral
>>    iommu/arm-smmu: remove arm_smmu_devices
>>    iommu/arm-smmu: rename __arm_smmu_get_pci_sid
>>    iommu/arm-smmu: add support for non-pci devices
>>    iommu/arm-smmu: describe the limitation of #iommu-cells
>>
>>   .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   6 +
>>   drivers/iommu/arm-smmu-v3.c                        | 209 ++++++++++++++++-----
>>   2 files changed, 163 insertions(+), 52 deletions(-)
>>
>> -- 
>> 1.8.0
>>
>>
> 
> 
> .
> 
