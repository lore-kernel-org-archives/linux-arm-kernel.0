From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Sun, 26 Oct 2014 13:43:07 +0100
Subject: [PATCH] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <544C2D67.8000405@suse.de>
References: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
 <544C2D67.8000405@suse.de>
Message-ID: <544CEC5B.4020104@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.10.2014 um 01:08 schrieb Alexander Graf:
> On 24.10.14 14:20, suravee.suthikulpanit at amd.com wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 48b7437..e4c052f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -137,6 +137,11 @@ source "kernel/Kconfig.freezer"
>>  
>>  menu "Platform selection"
>>  
>> +config ARCH_SEATTLE
>> +	bool "AMD Seattle SoC Family"
>> +	help
>> +	  This enables support for AMD Seattle SOC Family
>> +
>>  config ARCH_THUNDER
>>  	bool "Cavium Inc. Thunder SoC Family"
>>  	help
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index f8001a6..6c27047 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -1,6 +1,7 @@
>>  dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
>>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>> +dtb-$(CONFIG_ARCH_SEATTLE) += amd-seattle.dtb
> 
> This option doesn't exist in upstream kernels, does it? Why not just
> make it dtb-y?

CONFIG_ARCH_SEATTLE is being added one hunk above. :)

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
