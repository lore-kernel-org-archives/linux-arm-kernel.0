From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 6 Jun 2017 17:38:37 +0800
Subject: [v6 2/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
 erratum #74
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838351762@FRAEML521-MBX.china.huawei.com>
References: <1494592866-14076-1-git-send-email-gakula@caviumnetworks.com>
 <1494592866-14076-3-git-send-email-gakula@caviumnetworks.com>
 <5FC3163CFD30C246ABAA99954A238FA838351762@FRAEML521-MBX.china.huawei.com>
Message-ID: <9ab6fba9-5270-a618-d149-2e4c11d4cbf6@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/5/17 18:13, Shameerali Kolothum Thodi wrote:
>>   #ifdef CONFIG_ACPI
>> +static void acpi_smmu_get_options(u32 model, struct arm_smmu_device
>> +*smmu) {
>> +	if (model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
>> +		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
 >
> HiSIlicon hip06/07 boards have a similar existing option to enable,
> ARM_SMMU_OPT_SKIP_PREFETCH. I have just sent out a similar patch to enable
> It-" [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon CMD_PREFETCH
>   quirk(erratum 161010701)".  May be it can be merged here, if this series goes through.
>   Not sure about the protocol though.

I think you can add a patch on top of Geetha's, and clarify
the dependency in the change log, then it will be easy for
maintainer to apply.

Thanks
Hanjun
