From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 1 Jul 2016 11:06:35 -0400
Subject: [PATCH] arm64: defconfig: Enable QDF2432 config options
In-Reply-To: <57767AC1.3070209@codeaurora.org>
References: <1467382327-9726-1-git-send-email-cov@codeaurora.org>
 <57767AC1.3070209@codeaurora.org>
Message-ID: <577686FB.5040709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2016 10:14 AM, Timur Tabi wrote:
> Christopher Covington wrote:
>>   arch/arm64/configs/defconfig |  4 ++++
>>   scripts/patch-details.sh     | 21 ++++++++++++++++++---
> 
> I don't think these two files should be combined.

Oops, sorry. Fixed in v2.

>>  CONFIG_PINCTRL_SINGLE=y
>>  CONFIG_PINCTRL_MSM8916=y
>> +CONFIG_PINCTRL_QDF2XXX=m
>>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>>  CONFIG_GPIO_SYSFS=y
>>  CONFIG_GPIO_DWAPB=y
>> @@ -245,6 +246,7 @@ CONFIG_MMC=y
>>  CONFIG_MMC_BLOCK_MINORS=32
>>  CONFIG_MMC_ARMMMCI=y
>>  CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_ACPI=m
>>  CONFIG_MMC_SDHCI_PLTFM=y
> 
> Why are these =m when all the others are =y?

Due to distribution differences [1][2], I see =y built-in as the default
on mobile platforms and =m modular as the default on server platforms.

But thinking about it, we could get a poweroff, reset, over-temperature,
or other interrupt before we get to the initramfs. So the pin controller
driver should be =y built-in.

One might make rootfs media =y built-in to make testing easier, but I
prefer to put my rootfs on SATA, as SD/MMC is much slower and smaller by
comparison.

Thanks,
Cov

Examples I found to spot check my recollection:
1.
https://github.com/CyanogenMod/android_kernel_lge_hammerhead/blob/cm-13.0/arch/arm/configs/cyanogenmod_hammerhead_defconfig

2.
https://git.centos.org/blob/sig-altarch!kernel.git/c3cb6cc6edb5400321fd9d83413add4cf61d942e/SOURCES!config-arm64
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
