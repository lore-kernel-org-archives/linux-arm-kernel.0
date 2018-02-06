From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 5 Feb 2018 22:13:25 -0200
Subject: [v2] ARM: dts: imx: Add support for Advantech DMS-BA16
In-Reply-To: <20180206000501.14641-1-yungching0725@gmail.com>
References: <20180206000501.14641-1-yungching0725@gmail.com>
Message-ID: <CAOMZO5CzDXxyzG9yC+26X4Ubek0bWMa_gxfBc4iQpBGxhbQ5DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ken,

On Mon, Feb 5, 2018 at 10:05 PM, Ken Lin <yungching0725@gmail.com> wrote:

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..585c3da4a47a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -435,6 +435,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6q-dfi-fs700-m60.dtb \
>         imx6q-display5-tianma-tm070-1280x768.dtb \
>         imx6q-dmo-edmqmx6.dtb \
> +       imx6q-dms-ba16.dtb \
>         imx6q-evi.dtb \
>         imx6q-gk802.dtb \
>         imx6q-gw51xx.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-dms-ba16.dts b/arch/arm/boot/dts/imx6q-dms-ba16.dts
> new file mode 100644
> index 000000000000..055b88a6096d
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-dms-ba16.dts
> @@ -0,0 +1,146 @@
> +/*
> + * Copyright 2018 Advantech Corporation
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

You should put the SPDX line as the first line and it should start with //:

// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

> + */
> +
> +

No need for two blank lines. One is enough.

> +/dts-v1/;
> +
...

> +&ecspi5 {
> +       num-cs = <1>;

You can remove this property.


> +       cs-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi5>;
> +       status = "okay";
> +
> +       m25_eeprom: m25p80 at 0 {
> +               compatible = "atmel,at25";

According to Documentation/devicetree/bindings/eeprom/at25.txt this
should have the following format:

compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
