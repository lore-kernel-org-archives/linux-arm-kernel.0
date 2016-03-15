From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Mar 2016 11:42:10 +0900
Subject: [PATCH v2 5/7] ARM: dts: Add exynos3250-artik5 dtsi file for
 ARTIK5 module
In-Reply-To: <56E77492.7020200@samsung.com>
References: <1458007695-3627-1-git-send-email-cw00.choi@samsung.com>
 <1458007695-3627-6-git-send-email-cw00.choi@samsung.com>
 <56E77492.7020200@samsung.com>
Message-ID: <56E77682.8040904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 03? 15? 11:33, Krzysztof Kozlowski wrote:
> On 15.03.2016 11:08, Chanwoo Choi wrote:
>> This patch adds the support for Device Tree source for Samsung ARTIK5 module[1]
>> based on Exynos3250 SoC. The ARTIK5 module includes the follwoing devices:
>> - Application Processor (Samsung Exynos3250)
>> - WiFi/BT Combo chip (Broadcom4354)
>> - PMIC (Samsung S2MPS14)
>> - eMMC (4GB)
>> - DRAM LPDDR3 (512MB)
>> - Connectors pin (60 Pins x 3 set)
>>
>> Also, this patch adds the ARTIK5 evaluation board[2] dts file which includes
>> the ARTIK5 module[1] and have the devices such as sound codec, sd card port,
>> ethernet port, uart port and so on.
>>
>> [1] https://www.artik.io/hardware/artik-5
>> [2] http://www.digikey.com/product-search/en?FV=ffecca14
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>> ---
>>  .../bindings/arm/samsung/samsung-boards.txt        |   2 +
>>  arch/arm/boot/dts/Makefile                         |   1 +
>>  arch/arm/boot/dts/exynos3250-artik5-eval.dts       |  26 ++
>>  arch/arm/boot/dts/exynos3250-artik5.dtsi           | 334 +++++++++++++++++++++
>>  4 files changed, 363 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/exynos3250-artik5-eval.dts
>>  create mode 100644 arch/arm/boot/dts/exynos3250-artik5.dtsi
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> index 12129c011c8f..f5deace2b380 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> @@ -2,6 +2,8 @@
>>  
>>  Required root node properties:
>>      - compatible = should be one or more of the following.
>> +	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
>> +	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
>>  	- "samsung,monk"	- for Exynos3250-based Samsung Simband board.
>>  	- "samsung,rinato"	- for Exynos3250-based Samsung Gear2 board.
>>  	- "samsung,smdkv310"	- for Exynos4210-based Samsung SMDKV310 eval board.
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index a4a6d70e8b26..85cd586ea3d2 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -108,6 +108,7 @@ dtb-$(CONFIG_ARCH_DIGICOLOR) += \
>>  dtb-$(CONFIG_ARCH_EFM32) += \
>>  	efm32gg-dk3750.dtb
>>  dtb-$(CONFIG_ARCH_EXYNOS3) += \
>> +	exynos3250-artik5-eval.dtb \
>>  	exynos3250-monk.dtb \
>>  	exynos3250-rinato.dtb
>>  dtb-$(CONFIG_ARCH_EXYNOS4) += \
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
>> new file mode 100644
>> index 000000000000..b476154590a5
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
>> @@ -0,0 +1,26 @@
>> +/*
>> + * Samsung's Exynos3250 based ARTIK5 evaluation board device tree source
>> + *
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * Device tree source file for Samsung's ARTIK5 evaluation board
>> + * which is based on Samsung Exynos3250 SoC.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +#include "exynos3250-artik5.dtsi"
>> +
>> +/ {
>> +	model = "Samsung ARTIK5 evaluation board";
>> +	compatible = "samsung,artik5-eval", "samsung,artik5",
>> +			"samsung,exynos3250", "samsung,exynos3";
>> +};
>> +
>> +&serial_2 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> new file mode 100644
>> index 000000000000..206625ba8cf2
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> @@ -0,0 +1,334 @@
>> +/*
>> + * Samsung's Exynos3250 based ARTIK5 module device tree source
>> + *
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * Device tree source file for Samsung's ARTIK5 module which is based on
>> + * Samsung Exynos3250 SoC.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "exynos3250.dtsi"
>> +#include <dt-bindings/clock/samsung,s2mps11.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/gpio/gpio.h>
> 
> Alphabetical order for dt-bindings includes: interrupt at the end.

OK. I'll keep it.

> 
>> +
>> +/ {
>> +	compatible = "samsung,artik5", "samsung,exynos3250", "samsung,exynos3";
>> +
>> +	chosen {
>> +		stdout-path = &serial_2;
>> +	};
>> +
>> +	memory {
>> +		reg = <0x40000000 0x1ff00000>;
>> +	};
>> +
>> +	firmware at 0205F000 {
> 
> I meant same case for every hex, also in device node.

OK. I'll keep it.

> 
>> +		compatible = "samsung,secure-firmware";
>> +		reg = <0x0205f000 0x1000>;
>> +	};
>> +
>> +	thermal-zones {
>> +		cpu_thermal: cpu-thermal {
>> +			cooling-maps {
>> +				map0 {
>> +					/* Corresponds to 500MHz */
>> +					cooling-device = <&cpu0 5 5>;
>> +				};
>> +				map1 {
>> +					/* Corresponds to 200MHz */
>> +					cooling-device = <&cpu0 8 8>;
>> +				};

[snip]

>> +
>> +&mshc_0 {
>> +	num-slots = <1>;
>> +	non-removable;
>> +	cap-mmc-highspeed;
>> +	card-detect-delay = <200>;
>> +	vmmc-supply = <&ldo12_reg>;
>> +	clock-frequency = <100000000>;
>> +	clock-freq-min-max = <400000 100000000>;
>> +	samsung,dw-mshc-ciu-div = <1>;
>> +	samsung,dw-mshc-sdr-timing = <0 1>;
>> +	samsung,dw-mshc-ddr-timing = <1 2>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
>> +	bus-width = <8>;
>> +	status = "okay";
>> +};
>> +
>> +&tmu {
>> +	status = "okay";
>> +};
>> +
>> +&rtc {
>> +	clocks = <&cmu CLK_RTC>, <&s2mps14_osc S2MPS11_CLK_AP>;
>> +	clock-names = "rtc", "rtc_src";
>> +	status = "okay";
>> +};
> 
> Alphabetical order please, so rtc before tmu.
> 
> These are minor nits, so no need to resend. I can fix them when applying
> (but if resend happens then please fix them).
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Thanks for your fixup.

Best Regards,
Chanwoo Choi
