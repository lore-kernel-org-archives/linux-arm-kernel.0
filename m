From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 9 Mar 2017 13:02:46 +0100
Subject: [PATCH] iommu/arm-smmu: Report smmu type in dmesg
In-Reply-To: <4a991323-1059-5f3c-0aa3-0ab0cb7bd3f1@linaro.org>
References: <20170306135833.21455-1-rrichter@cavium.com>
 <4a991323-1059-5f3c-0aa3-0ab0cb7bd3f1@linaro.org>
Message-ID: <20170309120246.GQ16822@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.03.17 16:25:24, Aleksey Makarov wrote:

> >-#define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
> >-static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> >+#define ARM_SMMU_TYPE(var, ver, imp, _name)	\
> >+static struct arm_smmu_type var = { .version = ver, .model = imp, .name = _name }
> 
> Can we infer the _name from the name of var?
> 
> #define ARM_SMMU_TYPE(var, ver, imp)	\
> static struct arm_smmu_type var = { .version = ver, .model = imp, .name = #var }
> 
> >-ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
> >-ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> >-ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> >-ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> >-ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> >+ARM_SMMU_TYPE(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU, "smmu-generic-v1");
> >+ARM_SMMU_TYPE(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU, "smmu-generic-v2");
> >+ARM_SMMU_TYPE(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU, "arm-mmu401");
> >+ARM_SMMU_TYPE(arm_mmu500, ARM_SMMU_V2, ARM_MMU500, "arm-mmu500");
> >+ARM_SMMU_TYPE(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2, "cavium-smmuv2");

I thought about this but underscore names are not typical. Adding some
strings as names looks straighforward to me.

-Robert

> 
> So that this change will not be required?
