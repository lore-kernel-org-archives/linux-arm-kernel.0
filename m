From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 29 Jul 2016 10:38:43 -0300
Subject: [PATCH 2/2] ARM: dts: TS-4900: add basic device tree
In-Reply-To: <1469641982-19558-3-git-send-email-lucile.quirion@savoirfairelinux.com>
References: <1469641982-19558-1-git-send-email-lucile.quirion@savoirfairelinux.com>
 <1469641982-19558-3-git-send-email-lucile.quirion@savoirfairelinux.com>
Message-ID: <CAOMZO5AxNvQJv+JyfZDhv97FLmXZ8aMhvG8oPh6N4N1Njsci3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucile,

This looks good. Only some minor nits:

On Wed, Jul 27, 2016 at 2:53 PM, Lucile Quirion
<lucile.quirion@savoirfairelinux.com> wrote:

> @@ -0,0 +1,21 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */

If possible, please consider dual GPL/X11 license. Same applies to other files.

> +       reg_3p3v: regulator-3p3v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "3p3v";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;

This 'regulator-always-on' can be removed.

> +&i2c1 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default", "gpio";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +       scl-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +       sda-gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;

Please move 'status = "okay"' line to the end of the properties list.
Same apply to other nodes in this file.
