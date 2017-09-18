From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Sep 2017 13:06:13 -0300
Subject: [PATCH 1/2] dts: display5: Device tree description of LWN's
 DISPLAY5 board
In-Reply-To: <1505746765-965-1-git-send-email-lukma@denx.de>
References: <1505746765-965-1-git-send-email-lukma@denx.de>
Message-ID: <CAOMZO5Du4gH1jwcP4ssRPD17GsEAVERpkNBD7W2z5f+4TAd=nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Mon, Sep 18, 2017 at 11:59 AM, Lukasz Majewski <lukma@denx.de> wrote:

> diff --git a/arch/arm/boot/dts/imx6q-display5-mitsubishi-aa070-800x480.dts b/arch/arm/boot/dts/imx6q-display5-mitsubishi-aa070-800x480.dts
> new file mode 100644
> index 0000000..0160ecf
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-display5-mitsubishi-aa070-800x480.dts
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright 2017
> + * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Have you considered using a dual GPL/X11 license? Same apply to the
other new dts/dtsi files.

> +/dts-v1/;
> +
> +#include "imx6q-display5.dtsi"
> +
> +&panel {
> +       compatible = "mitsubishi,aa070mc01-ca1";

I don't see this binding accepted in mainline, so it would be better
to resend it after it reaches mainline.

> +&ssi2 {
> +       fsl,mode = "i2s-master";

Please remove this property. simple-audio-card already specifies who is master.

> +       pinctrl_ecspi2_cs: ecspi2csgrp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29 0x80000000

Please do not use 0x80000000. Use the real IOMUX value instead.

> +               >;
> +       };
> +
> +       pinctrl_ecspi2_flwp: ecspi2flwpgrp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000

Ditto.

> +               >;
> +       };
> +
> +       pinctrl_ecspi3: ecspi3grp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO      0x100b1
> +                       MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI      0x100b1
> +                       MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK      0x100b1
> +               >;
> +       };
> +
> +       pinctrl_ecspi3_cs: ecspi3csgrp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000

Ditto.

> +               >;
> +       };
> +
> +       pinctrl_ecspi3_flwp: ecspi3flwpgrp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27 0x80000000

Ditto.
