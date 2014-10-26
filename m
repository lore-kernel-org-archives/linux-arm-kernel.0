From: agraf@suse.de (Alexander Graf)
Date: Sun, 26 Oct 2014 15:08:45 +0100
Subject: [PATCH] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <544CEC5B.4020104@suse.de>
References: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
 <544C2D67.8000405@suse.de> <544CEC5B.4020104@suse.de>
Message-ID: <A1BC53C1-A78E-4B0C-879B-F6A462E58C72@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




> Am 26.10.2014 um 13:43 schrieb Andreas F?rber <afaerber@suse.de>:
> 
>> Am 26.10.2014 um 01:08 schrieb Alexander Graf:
>>> On 24.10.14 14:20, suravee.suthikulpanit at amd.com wrote:
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 48b7437..e4c052f 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -137,6 +137,11 @@ source "kernel/Kconfig.freezer"
>>> 
>>> menu "Platform selection"
>>> 
>>> +config ARCH_SEATTLE
>>> +    bool "AMD Seattle SoC Family"
>>> +    help
>>> +      This enables support for AMD Seattle SOC Family
>>> +
>>> config ARCH_THUNDER
>>>    bool "Cavium Inc. Thunder SoC Family"
>>>    help
>>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>>> index f8001a6..6c27047 100644
>>> --- a/arch/arm64/boot/dts/Makefile
>>> +++ b/arch/arm64/boot/dts/Makefile
>>> @@ -1,6 +1,7 @@
>>> dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
>>> dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>>> dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>>> +dtb-$(CONFIG_ARCH_SEATTLE) += amd-seattle.dtb
>> 
>> This option doesn't exist in upstream kernels, does it? Why not just
>> make it dtb-y?
> 
> CONFIG_ARCH_SEATTLE is being added one hunk above. :)

Oops :).

I'm not convinced we need a config option just for the sake of compiling a device tree though.


Alex
