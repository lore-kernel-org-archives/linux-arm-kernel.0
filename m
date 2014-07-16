From: dianders@chromium.org (Doug Anderson)
Date: Wed, 16 Jul 2014 13:02:53 -0700
Subject: [PATCH 6/6] ARM: dts: add rk3288 evaluation board
In-Reply-To: <2186895.xqgxh7zegl@diego>
References: <1471578.ILeMmG2DL6@diego>
	<2186895.xqgxh7zegl@diego>
Message-ID: <CAD=FV=Vo-J2cmyUZfD6KUdvw=5iaCgANsSvaSKfuJRWz1DCCeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Jul 15, 2014 at 4:02 PM, Heiko St?bner <heiko@sntech.de> wrote:
> diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
> new file mode 100644
> index 0000000..c168cb2
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
> @@ -0,0 +1,19 @@
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
> +

nit: remove extra blank line?

> +};
> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
> new file mode 100644
> index 0000000..ff642d4
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
> @@ -0,0 +1,77 @@
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

Can the aliases go in the main dtsi?

> +       };
> +
> +       memory {
> +               reg = <0x0 0x80000000>;
> +       };
> +
> +       soc {
> +               gpio-keys {
> +                       compatible = "gpio-keys";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       autorepeat;

I would have expected pinctrl for gpio0-5 to make sure pulls are
enabled / disabled as appropriate.

> +
> +                       button at 0 {
> +                               gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
> +                               linux,code = <116>;
> +                               label = "GPIO Key Power";
> +                               linux,input-type = <1>;
> +                               gpio-key,wakeup = <1>;
> +                               debounce-interval = <100>;
> +                       };
> +               };
> +
> +               i2c0: i2c at ff650000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c0_xfer>;
> +                       status = "okay";
> +               };
> +
> +               watchdog at ff800000 {
> +                       status = "okay";
> +               };
> +
> +               serial at ff180000 {
> +                       status = "okay";
> +               };
> +
> +               serial at ff190000 {
> +                       status = "okay";
> +               };
> +
> +               uart2: serial at ff690000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&uart2_xfer>;

Why is this pinctrl here?

> +                       status = "okay";
> +               };
