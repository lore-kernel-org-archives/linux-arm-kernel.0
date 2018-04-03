From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 3 Apr 2018 20:39:01 -0300
Subject: [PATCH v2] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
In-Reply-To: <20180403165945.3981-1-lukma@denx.de>
References: <20180403165945.3981-1-lukma@denx.de>
Message-ID: <CAOMZO5BMWtWo6O_qKOsA_27xaReGDGczrujqRW8k23pkwscvDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Tue, Apr 3, 2018 at 1:59 PM, Lukasz Majewski <lukma@denx.de> wrote:

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ae850d6c0ad3..8ff7eadc8bef 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -181,6 +181,7 @@ karo        Ka-Ro electronics GmbH
>  keithkoep      Keith & Koep GmbH
>  keymile        Keymile GmbH
>  khadas Khadas
> +kiebackpeter    Kieback & Peter GmbH

This should be a separate patch.

>  kinetic Kinetic Technologies
>  kingnovel      Kingnovel Technology Co., Ltd.
>  kosagi Sutajio Ko-Usagi PTE Ltd.
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..c148c4cf28f2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -459,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6q-icore-ofcap10.dtb \
>         imx6q-icore-ofcap12.dtb \
>         imx6q-icore-rqs.dtb \
> +       imx6q-kp-tpc.dtb \
>         imx6q-marsboard.dtb \
>         imx6q-mccmon6.dtb \
>         imx6q-nitrogen6x.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> new file mode 100644
> index 000000000000..b5646040b516
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

This line should be the first one and start with //

> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q-kp.dtsi"
> +
> +/ {
> +       model = "Freescale i.MX6 Qwuad K+P TPC Board";
> +       compatible = "kiebackpeter,imx6q-tpc", "fsl,imx6q";
> +
> +       memory: memory at 10000000 {

Only memory at 10000000 is enough.

> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> @@ -0,0 +1,460 @@
> +/*
> + * Copyright 2018
> + * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Same here.

> +       beeper {
> +               compatible = "pwm-beeper";
> +               pwms = <&pwm2 0 500000>; //2kHz

No // style comments, please.

> +       lcd_panel: lcd-panel {
> +               compatible = "auo,g070vvn01";

I don't see this compatible string in linux-next.

> +&i2c1 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       goodix_ts at 5d {
> +               compatible = "goodix,gt911";
> +               reg = <0x5d>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_ts>;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +               irq-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +               reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       rx8025 at 32 {
> +               compatible = "dallas,rx8025";

I don't see this compatible string in linux-next.
