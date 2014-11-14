From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 14 Nov 2014 13:55:51 +0100
Subject: [PATCH v7 1/3] ARM: mediatek: Add basic support for mt6592
In-Reply-To: <1415942094-11451-1-git-send-email-ibanezchen@gmail.com>
References: <1415942094-11451-1-git-send-email-ibanezchen@gmail.com>
Message-ID: <CABuKBeKiXn6=xdTYKWea3M=w6+0FfLeWFZtjVkfdyUSR3SfNsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-14 6:14 GMT+01:00 Howard Chen <ibanezchen@gmail.com>:
> * A dtsi for boards based on Mediatek MT6592 SoCs
> * Compatible string in arch/arm/mach-mediatek/mediatek.c
>
> Signed-off-by: Howard Chen <ibanezchen@gmail.com>

I applied the whole series [0].
Thanks.

[0] https://github.com/mbgg/linux-mediatek/commits/v3.19-next/dts

> ---
>  arch/arm/boot/dts/mt6592.dtsi     | 97 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mediatek/mediatek.c |  1 +
>  2 files changed, 98 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mt6592.dtsi
>
> diff --git a/arch/arm/boot/dts/mt6592.dtsi b/arch/arm/boot/dts/mt6592.dtsi
> new file mode 100644
> index 0000000..65aa81b
> --- /dev/null
> +++ b/arch/arm/boot/dts/mt6592.dtsi
> @@ -0,0 +1,97 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Howard Chen <ibanezchen@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include "skeleton.dtsi"
> +
> +/ {
> +       compatible = "mediatek,mt6592";
> +       interrupt-parent = <&gic>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x0>;
> +               };
> +               cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x1>;
> +               };
> +               cpu at 2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x2>;
> +               };
> +               cpu at 3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x3>;
> +               };
> +               cpu at 4 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x4>;
> +               };
> +               cpu at 5 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x5>;
> +               };
> +               cpu at 6 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x6>;
> +               };
> +               cpu at 7 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x7>;
> +               };
> +       };
> +
> +       system_clk: dummy13m {
> +               compatible = "fixed-clock";
> +               clock-frequency = <13000000>;
> +               #clock-cells = <0>;
> +       };
> +
> +       rtc_clk: dummy32k {
> +               compatible = "fixed-clock";
> +               clock-frequency = <32000>;
> +               #clock-cells = <0>;
> +       };
> +
> +       timer: timer at 10008000 {
> +               compatible = "mediatek,mt6577-timer";
> +               reg = <0x10008000 0x80>;
> +               interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&system_clk>, <&rtc_clk>;
> +               clock-names = "system-clk", "rtc-clk";
> +       };
> +
> +       gic: interrupt-controller at 10211000 {
> +               compatible = "arm,cortex-a7-gic";
> +               interrupt-controller;
> +               #interrupt-cells = <3>;
> +               reg = <0x10211000 0x1000>,
> +                     <0x10212000 0x1000>;
> +       };
> +
> +};
> diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
> index f2acf07..88e4626 100644
> --- a/arch/arm/mach-mediatek/mediatek.c
> +++ b/arch/arm/mach-mediatek/mediatek.c
> @@ -19,6 +19,7 @@
>
>  static const char * const mediatek_board_dt_compat[] = {
>         "mediatek,mt6589",
> +       "mediatek,mt6592",
>         NULL,
>  };
>
> --
> 1.9.1
>



-- 
motzblog.wordpress.com
