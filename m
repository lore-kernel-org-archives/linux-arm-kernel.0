From: dianders@chromium.org (Doug Anderson)
Date: Thu, 24 Jul 2014 16:17:58 -0700
Subject: [PATCH v2 7/7] ARM: dts: add rk3288 evaluation board
In-Reply-To: <2004020.THrDyKm3fa@diego>
References: <4868343.UFgjaXesOn@diego>
	<2004020.THrDyKm3fa@diego>
Message-ID: <CAD=FV=W9SxW-g+v-VRbJXMTt3njUvvU4mOvOke-s=ihve4ghfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Thu, Jul 17, 2014 at 5:21 PM, Heiko St?bner <heiko@sntech.de> wrote:
> There exist 2 variants using either the act8846 or rk808 as pmic, while the
> rest of the board stays the same.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/boot/dts/rk3288-evb-act8846.dts | 134 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/rk3288-evb-rk808.dts   |  18 +++++
>  arch/arm/boot/dts/rk3288-evb.dtsi        |  83 +++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-evb-act8846.dts
>  create mode 100644 arch/arm/boot/dts/rk3288-evb-rk808.dts
>  create mode 100644 arch/arm/boot/dts/rk3288-evb.dtsi
>
> diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
> new file mode 100644
> index 0000000..7d59ff4
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
> @@ -0,0 +1,134 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +#include "rk3288-evb.dtsi"
> +
> +/ {
> +       compatible = "rockchip,rk3288-evb-act8846", "rockchip,rk3288";
> +};
> +
> +&i2c0 {
> +       hym8563 at 51 {
> +               compatible = "haoyu,hym8563";
> +               reg = <0x51>;
> +
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hym8563_int>;
> +
> +               #clock-cells = <0>;
> +               clock-output-names = "xin32k";
> +       };
> +
> +       act8846: act8846 at 5a {
> +               compatible = "active-semi,act8846";
> +               reg = <0x5a>;
> +               status = "okay";
> +
> +               regulators {
> +                       vcc_ddr: REG1 {
> +                               regulator-name = "VCC_DDR";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vcc_io: REG2 {
> +                               regulator-name = "VCC_IO";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vdd_log: REG3 {
> +                               regulator-name = "VDD_LOG";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vcc_20: REG4 {
> +                               regulator-name = "VCC_20";
> +                               regulator-min-microvolt = <2000000>;
> +                               regulator-max-microvolt = <2000000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vccio_sd: REG5 {
> +                               regulator-name = "VCCIO_SD";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vdd10_lcd: REG6 {
> +                               regulator-name = "VDD10_LCD";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vcca_codec: REG7 {
> +                               regulator-name = "VCCA_CODEC";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vcca_tp: REG8 {
> +                               regulator-name = "VCCA_TP";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vccio_pmu: REG9 {
> +                               regulator-name = "VCCIO_PMU";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vdd_10: REG10 {
> +                               regulator-name = "VDD_10";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vcc_18: REG11 {
> +                               regulator-name = "VCC_18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vcc18_lcd: REG12 {
> +                               regulator-name = "VCC18_LCD";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-always-on;
> +                       };
> +               };
> +       };
> +};
> +
> +&pinctrl {
> +       hym8563 {
> +               hym8563_int: hym8563-int {
> +                       rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +       };
> +};
> diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
> new file mode 100644
> index 0000000..9a88b6c
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
> @@ -0,0 +1,18 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +#include "rk3288-evb.dtsi"
> +
> +/ {
> +       compatible = "rockchip,rk3288-evb-rk808", "rockchip,rk3288";
> +};
> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
> new file mode 100644
> index 0000000..2afd4f2
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
> @@ -0,0 +1,83 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "rk3288.dtsi"
> +
> +/ {
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +               serial3 = &uart3;
> +               serial4 = &uart4;

You've got these aliases in the main dtsi at
<https://patchwork.kernel.org/patch/4579531/>.  You don't need them
here, too.


> +       };
> +
> +       memory {
> +               reg = <0x0 0x80000000>;
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               autorepeat;
> +
> +               button at 0 {
> +                       gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
> +                       linux,code = <116>;
> +                       label = "GPIO Key Power";
> +                       linux,input-type = <1>;
> +                       gpio-key,wakeup = <1>;
> +                       debounce-interval = <100>;
> +               };
> +       };
> +
> +       i2c0: i2c at ff650000 {

I think Olof was suggesting enabling these things via aliases.  In
other words, move to the top level and do:

&i2c0 {
  pinctrl-names = "default";
  pinctrl-0 = <&i2c0_xfer>;
  status = "okay";
};

...same for other peripherals here.

Also: you made an argument for why you don't have the UART config in
the main 3288 dtsi file (because you thought boards might want to
enable flow control).  ...but why can't i2c go in the main 3288 dtsi
file?


> +               pinctrl-names = "default";
> +               pinctrl-0 = <&i2c0_xfer>;
> +               status = "okay";
> +       };
> +
> +       watchdog at ff800000 {
> +               status = "okay";
> +       };
> +
> +       serial at ff180000 {
> +               status = "okay";

How do these work without a pinctrl?


> +       };
> +
> +       serial at ff190000 {
> +               status = "okay";
> +       };
> +
> +       serial at ff690000 {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&uart2_xfer>;

Note: you could still put just the "xfer" in the main 3288 dtsi file
and boards could just override pinctrl-0 to include the CTS/RTS if
they want.


> +               status = "okay";
> +       };
> +
> +       serial at ff1b0000 {
> +               status = "okay";
> +       };
> +
> +       serial at ff1c0000 {
> +               status = "okay";
> +       };
> +
> +       pinctrl {
> +               buttons {
> +                       pwrbtn: pwrbtn {
> +                               rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
> +                       };

Don't you need to refer to this somewhere?  I think you need to refer
to them in "pinctrl-0" of "gpio-keys".  See exynos5420-peach-pit.dts

-Doug
