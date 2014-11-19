From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Nov 2014 16:47:05 +0900
Subject: [PATCH v2] ARM: dts: add board dts file for Exynos3250-based
 Monk board
In-Reply-To: <546AE8EC.9010708@samsung.com>
References: <20141002112233.GI5788@leverpostej>
 <1412734265-6259-1-git-send-email-yj44.cho@samsung.com>
 <546AE8EC.9010708@samsung.com>
Message-ID: <546C4AF9.2060306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/14 15:36, Chanwoo Choi wrote:
> Dear Kukjin,
> 
Hi,

> Could you please review or pick this patchset?
> 
> Best Regards,
> Chanwoo Choi
> 
> On 10/08/2014 11:11 AM, YoungJun Cho wrote:
>> From: Youngjun Cho <yj44.cho@samsung.com>
>>
>> This patch adds new board dts file to support Samsung Monk board which is
>> based on Exynos3250 SoC and has different H/W configuration from Rinato.
>>
>> This patch is based on linux-samsung.git for-next branch and depends on
>> [PATCHv2 0/2] ARM: dts: Add new board dts file for Exynos3250-based Rinato board
>>
>> Changes from v1:
>> - The 'memory' entries coalesce into one entry
>> - Removes useless space
>> - Puts voltage-regulator-0 under the root node
>>
>> This dts file support following features:
>> - eMMC
>> - Main PMIC (Samsung S2MPS14)
>> - Interface PMIC (Maxim MAX77836, MUIC, fuel-gauge, charger)
>> - RTC of Exynos3250
>> - ADC of Exynos3250 with NTC thermistor
>> - I2S of Exynos3250
>> - TMU of Exynos3250
>> - Secure firmware for Exynos3250 secondary cpu boot
>> - Serial ports of Exynos3250
>> - gpio-key for power key
>>
>> Signed-off-by: Youngjun Cho <yj44.cho@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/boot/dts/Makefile            |   3 +-
>>  arch/arm/boot/dts/exynos3250-monk.dts | 583 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 585 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/exynos3250-monk.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 5728918..0c8ae64 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -64,7 +64,8 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
>>  dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
>>  	da850-evm.dtb
>>  dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
>> -dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-rinato.dtb \
>> +dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-monk.dtb \
>> +	exynos3250-rinato.dtb \
>>  	exynos4210-origen.dtb \
>>  	exynos4210-smdkv310.dtb \
>>  	exynos4210-trats.dtb \
>> diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
>> new file mode 100644
>> index 0000000..615672f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos3250-monk.dts
>> @@ -0,0 +1,583 @@
>> +/*
>> + * Samsung's Exynos3250 based Monk board device tree source
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * Device tree source file for Samsung's Monk board which is based on
>> + * Samsung Exynos3250 SoC.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +#include "exynos3250.dtsi"
>> +#include <dt-bindings/input/input.h>
>> +
>> +/ {
>> +	model = "Samsung Monk board";
>> +	compatible = "samsung,monk", "samsung,exynos3250", "samsung,exynos3";
>> +
>> +	aliases {
>> +		i2c7 = &i2c_max77836;
>> +	};
>> +
>> +	memory {
>> +		reg =  <0x40000000 0x1ff00000>;
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "console=ttySAC1,115200N8 root=/dev/mmcblk0p15 rootwait earlyprintk panic=5";

Actually, the bootargs can be supplied from bootloader and can be
removed from here and it's a recent requirement from mailinglist. But
I've already applied similar one in rinato.dts. So please cleanup them
together later...? :)

[snip]

Will apply, thanks.

- Kukjin
