From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 17 Aug 2012 10:50:24 +0530
Subject: [PATCH 1/2] ARM: dts: Add pinctrl node entries for Samsung
 Exynos4210 SoC
In-Reply-To: <CAKGA1b=nXbTU70tFWWwvKoA6N4bMjG9R-vs2egppzQbwgkxAVw@mail.gmail.com>
References: <1345061442-32378-1-git-send-email-thomas.abraham@linaro.org>
 <1345061442-32378-2-git-send-email-thomas.abraham@linaro.org>
 <CAKGA1b=nXbTU70tFWWwvKoA6N4bMjG9R-vs2egppzQbwgkxAVw@mail.gmail.com>
Message-ID: <CAJuYYwTG=GgricAJRHiSQBn6ZAOy+sucFCdDX3QhgfSQFwuKaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2012 00:26, Matt Sealey <matt@genesi-usa.com> wrote:
> Re: samsung,pin-function samsung,pin-pud samsung,pin-drv - why can't
> these be one property, why take the space to define them individually
> instead of in an array of 3 values under one property name?

Samsung pinctrl driver was written to be usable on all of the Samsung
application processors starting from 24xx series to the latest
Exynos5.

The gpio/pinmux/pinconfig controllers on these SoC have varying
capabilities. Some of the banks in s3c24xx series support mux function
but do not support pull up/down (pud) or driver strength (drv).
s3c64xx soc's have banks that support pin mux and 'pud' but do not
support 'drv'. And there are banks that do not support mux function
but support 'pud' and 'drv'. Further, a given SoC can have multiple
combinations of different bank types.

In addition to this, there are two more properties for mux and pud
values in power down mode in some of the samsung SoC's.

To keep the bindings common across all the possible Samsung SoC's, the
mux, pud and drv properties were split so that the parsing code in the
Samsung pinctrl driver remains generic for all the possible
combinations of pin banks and SoC's.

Thanks,
Thomas.


>
> --
> Matt Sealey <matt@genesi-usa.com>
> Product Development Analyst, Genesi USA, Inc.
>
>
> On Wed, Aug 15, 2012 at 3:10 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> Add pinctrl driver nodes for the three instances of pin controllers
>> in Samsung Exynos4210 SoC and add the pin group nodes available in the
>> each of those three instances.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>  arch/arm/boot/dts/exynos4210-pinctrl.dtsi |  457 +++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/exynos4210.dtsi         |   37 +++
>>  2 files changed, 494 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/exynos4210-pinctrl.dtsi
>>
>> diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
>> new file mode 100644
>> index 0000000..b12cf27
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
>> @@ -0,0 +1,457 @@
>> +/*
>> + * Samsung's Exynos4210 SoC pin-mux and pin-config device tree source
>> + *
>> + * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
>> + *             http://www.samsung.com
>> + * Copyright (c) 2011-2012 Linaro Ltd.
>> + *             www.linaro.org
>> + *
>> + * Samsung's Exynos4210 SoC pin-mux and pin-config optiosn are listed as device
>> + * tree nodes are listed in this file.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +/ {
>> +       pinctrl at 11400000 {
>> +               uart0_data: uart0-data {
>> +                       samsung,pins = "gpa0-0", "gpa0-1";
>> +                       samsung,pin-function = <0x2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               uart0_fctl: uart0-fctl {
>> +                       samsung,pins = "gpa0-2", "gpa0-3";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               uart1_data: uart1-data {
>> +                       samsung,pins = "gpa0-4", "gpa0-5";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               uart1_fctl: uart1-fctl {
>> +                       samsung,pins = "gpa0-6", "gpa0-7";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2c2_bus: i2c2-bus {
>> +                       samsung,pins = "gpa0-6", "gpa0-7";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               uart2_data: uart2-data {
>> +                       samsung,pins = "gpa1-0", "gpa1-1";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               uart2_fctl: uart2-fctl {
>> +                       samsung,pins = "gpa1-2", "gpa1-3";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               uart_audio_a: uart-audio-a {
>> +                       samsung,pins = "gpa1-0", "gpa1-1";
>> +                       samsung,pin-function = <4>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2c3_bus: i2c3-bus {
>> +                       samsung,pins = "gpa1-2", "gpa1-3";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               uart3_data: uart3-data {
>> +                       samsung,pins = "gpa1-4", "gpa1-5";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               uart_audio_b: uart-audio-b {
>> +                       samsung,pins = "gpa1-4", "gpa1-5";
>> +                       samsung,pin-function = <4>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               spi0_bus: spi0-bus {
>> +                       samsung,pins = "gpb-0", "gpb-2", "gpb-3";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2c4_bus: i2c4-bus {
>> +                       samsung,pins = "gpb-2", "gpb-3";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               spi1_bus: spi1-bus {
>> +                       samsung,pins = "gpb-4", "gpb-6", "gpb-7";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2c5_bus: i2c5-bus {
>> +                       samsung,pins = "gpb-6", "gpb-7";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2s1_bus: i2s1-bus {
>> +                       samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
>> +                                       "gpc0-4";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               pcm1_bus: pcm1-bus {
>> +                       samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
>> +                                       "gpc0-4";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               ac97_bus: ac97-bus {
>> +                       samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
>> +                                       "gpc0-4";
>> +                       samsung,pin-function = <4>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2s2_bus: i2s2-bus {
>> +                       samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
>> +                                       "gpc1-4";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               pcm2_bus: pcm2-bus {
>> +                       samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
>> +                                       "gpc1-4";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               spdif_bus: spdif-bus {
>> +                       samsung,pins = "gpc1-0", "gpc1-1";
>> +                       samsung,pin-function = <4>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2c6_bus: i2c6-bus {
>> +                       samsung,pins = "gpc1-3", "gpc1-4";
>> +                       samsung,pin-function = <4>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               spi2_bus: spi2-bus {
>> +                       samsung,pins = "gpc1-1", "gpc1-2", "gpc1-3", "gpc1-4";
>> +                       samsung,pin-function = <5>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2c7_bus: i2c7-bus {
>> +                       samsung,pins = "gpd0-2", "gpd0-3";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2c0_bus: i2c0-bus {
>> +                       samsung,pins = "gpd1-0", "gpd1-1";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               i2c1_bus: i2c1-bus {
>> +                       samsung,pins = "gpd1-2", "gpd1-3";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +       };
>> +
>> +       pinctrl at 11000000 {
>> +               sd0_clk: sd0-clk {
>> +                       samsung,pins = "gpk0-0";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd0_cmd: sd0-cmd {
>> +                       samsung,pins = "gpk0-1";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd0_cd: sd0-cd {
>> +                       samsung,pins = "gpk0-2";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd0_bus1: sd0-bus-width1 {
>> +                       samsung,pins = "gpk0-3";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd0_bus4: sd0-bus-width4 {
>> +                       samsung,pins = "gpk0-3", "gpk0-4", "gpk0-5", "gpk0-6";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd0_bus8: sd0-bus-width8 {
>> +                       samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd4_clk: sd4-clk {
>> +                       samsung,pins = "gpk0-0";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd4_cmd: sd4-cmd {
>> +                       samsung,pins = "gpk0-1";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd4_cd: sd4-cd {
>> +                       samsung,pins = "gpk0-2";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd4_bus1: sd4-bus-width1 {
>> +                       samsung,pins = "gpk0-3";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd4_bus4: sd4-bus-width4 {
>> +                       samsung,pins = "gpk0-3", "gpk0-4", "gpk0-5", "gpk0-6";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd4_bus8: sd4-bus-width8 {
>> +                       samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <4>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd1_clk: sd1-clk {
>> +                       samsung,pins = "gpk1-0";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd1_cmd: sd1-cmd {
>> +                       samsung,pins = "gpk1-1";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd1_cd: sd1-cd {
>> +                       samsung,pins = "gpk1-2";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd1_bus1: sd1-bus-width1 {
>> +                       samsung,pins = "gpk1-3";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd1_bus4: sd1-bus-width4 {
>> +                       samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd2_clk: sd2-clk {
>> +                       samsung,pins = "gpk2-0";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd2_cmd: sd2-cmd {
>> +                       samsung,pins = "gpk2-1";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd2_cd: sd2-cd {
>> +                       samsung,pins = "gpk2-2";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd2_bus1: sd2-bus-width1 {
>> +                       samsung,pins = "gpk2-3";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd2_bus4: sd2-bus-width4 {
>> +                       samsung,pins = "gpk2-3", "gpk2-4", "gpk2-5", "gpk2-6";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd2_bus8: sd2-bus-width8 {
>> +                       samsung,pins = "gpk3-3", "gpk3-4", "gpk3-5", "gpk3-6";
>> +                       samsung,pin-function = <3>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd3_clk: sd3-clk {
>> +                       samsung,pins = "gpk3-0";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd3_cmd: sd3-cmd {
>> +                       samsung,pins = "gpk3-1";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd3_cd: sd3-cd {
>> +                       samsung,pins = "gpk3-2";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd3_bus1: sd3-bus-width1 {
>> +                       samsung,pins = "gpk3-3";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               sd3_bus4: sd3-bus-width4 {
>> +                       samsung,pins = "gpk3-3", "gpk3-4", "gpk3-5", "gpk3-6";
>> +                       samsung,pin-function = <2>;
>> +                       samsung,pin-pud = <3>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               eint0: ext-int0 {
>> +                       samsung,pins = "gpx0-0";
>> +                       samsung,pin-function = <0xf>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               eint8: ext-int8 {
>> +                       samsung,pins = "gpx1-0";
>> +                       samsung,pin-function = <0xf>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               eint15: ext-int15 {
>> +                       samsung,pins = "gpx1-7";
>> +                       samsung,pin-function = <0xf>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               eint16: ext-int16 {
>> +                       samsung,pins = "gpx2-0";
>> +                       samsung,pin-function = <0xf>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               eint31: ext-int31 {
>> +                       samsung,pins = "gpx3-7";
>> +                       samsung,pin-function = <0xf>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +       };
>> +
>> +       pinctrl at 03860000 {
>> +               i2s0_bus: i2s0-bus {
>> +                       samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
>> +                                       "gpz-4", "gpz-5", "gpz-6";
>> +                       samsung,pin-function = <0x2>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +
>> +               pcm0_bus: pcm0-bus {
>> +                       samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
>> +                                       "gpz-4";
>> +                       samsung,pin-function = <0x3>;
>> +                       samsung,pin-pud = <0>;
>> +                       samsung,pin-drv = <0>;
>> +               };
>> +       };
>> +};
>> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
>> index 02891fe..a4bd0c9 100644
>> --- a/arch/arm/boot/dts/exynos4210.dtsi
>> +++ b/arch/arm/boot/dts/exynos4210.dtsi
>> @@ -20,6 +20,7 @@
>>  */
>>
>>  /include/ "skeleton.dtsi"
>> +/include/ "exynos4210-pinctrl.dtsi"
>>
>>  / {
>>         compatible = "samsung,exynos4210";
>> @@ -29,6 +30,9 @@
>>                 spi0 = &spi_0;
>>                 spi1 = &spi_1;
>>                 spi2 = &spi_2;
>> +               pinctrl0 = &pinctrl_0;
>> +               pinctrl1 = &pinctrl_1;
>> +               pinctrl2 = &pinctrl_2;
>>         };
>>
>>         gic:interrupt-controller at 10490000 {
>> @@ -50,6 +54,39 @@
>>                              <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
>>         };
>>
>> +       pinctrl_0: pinctrl at 11400000 {
>> +               compatible = "samsung,pinctrl-exynos4210";
>> +               reg = <0x11400000 0x1000>;
>> +               interrupts = <0 47 0>;
>> +               interrupt-controller;
>> +               #interrupt-cells = <2>;
>> +       };
>> +
>> +       pinctrl_1: pinctrl at 11000000 {
>> +               compatible = "samsung,pinctrl-exynos4210";
>> +               reg = <0x11000000 0x1000>;
>> +               interrupts = <0 46 0>;
>> +               interrupt-controller;
>> +               #interrupt-cells = <2>;
>> +
>> +               wakup_eint: wakeup-interrupt-controller {
>> +                       compatible = "samsung,exynos4210-wakeup-eint";
>> +                       interrupt-parent = <&gic>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <2>;
>> +                       interrupts = <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
>> +                                       <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
>> +                                       <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
>> +                                       <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>,
>> +                                       <0 32 0>;
>> +               };
>> +       };
>> +
>> +       pinctrl_2: pinctrl at 03860000 {
>> +               compatible = "samsung,pinctrl-exynos4210";
>> +               reg = <0x03860000 0x1000>;
>> +       };
>> +
>>         watchdog at 10060000 {
>>                 compatible = "samsung,s3c2410-wdt";
>>                 reg = <0x10060000 0x100>;
>> --
>> 1.6.6.rc2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
