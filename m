From: pku.leo@gmail.com (Yang Li)
Date: Mon, 24 Apr 2017 12:20:32 -0500
Subject: [PATCH] arm64: dts: freescale: ls2081ardb: Add DTS support for
 NXP LS2081ARDB
In-Reply-To: <1492663067-2364-1-git-send-email-priyanka.jain@nxp.com>
References: <1492663067-2364-1-git-send-email-priyanka.jain@nxp.com>
Message-ID: <CADRPPNRM9Orc=RtRJstA-qpCcdCvrgab0n3d=CC7i6O7ua8nNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We probably should rename the freescale folder to nxp with a separate
patch, but it is better to stop using the name in the patch title
right now.

On Wed, Apr 19, 2017 at 11:37 PM, Priyanka Jain <priyanka.jain@nxp.com> wrote:
> This patch add support for NXP LS2081ARDB board which has
> LS2081A SoC.
>
> LS2081A SoC is 40-pin derivative of LS2088A SoC
> So, from functional perspective both are same.
> Hence,ls2088a SoC dtsi files are included from ls2081ARDB dts
>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts |  139 +++++++++++++++++++++
>  2 files changed, 140 insertions(+), 0 deletions(-)
>  create mode 100755 arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 72c4b52..58b80de 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2081a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> new file mode 100444
> index 0000000..7ae408e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> @@ -0,0 +1,139 @@
> +/*
> + * Device Tree file for NXP LS2081A RDB Board.
> + *
> + * Copyright (C) 2017, NXP Semiconductors

The formal copyright claim formal should be
Copyright 2017 NXP

> + *
> + * Priyanka Jain <priyanka.jain@nxp.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +
> +#include "fsl-ls2088a.dtsi"
> +
> +/ {
> +       model = "NXP Layerscape 2081A RDB Board";
> +       compatible = "fsl,ls2081a-rdb", "fsl,ls2081a";
> +
> +       aliases {
> +               serial0 = &serial0;
> +               serial1 = &serial1;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial1:115200n8";
> +       };
> +};
> +
> +&esdhc {
> +       status = "okay";
> +};
> +
> +&ifc {
> +       status = "disabled";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       pca9547 at 75 {
> +               compatible = "nxp,pca9547";
> +               reg = <0x75>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               i2c at 1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x01>;
> +                       rtc at 51 {
> +                               compatible = "nxp,pcf2129";
> +                               reg = <0x51>;
> +                       };
> +               };
> +
> +               i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +
> +                       adt7481 at 4c {
> +                               compatible = "adi,adt7461";
> +                               reg = <0x4c>;
> +                       };
> +               };
> +       };
> +};
> +
> +&dspi {
> +       status = "okay";
> +       dflash0: n25q512a {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "st,m25p80";
> +               spi-max-frequency = <3000000>;
> +               reg = <0>;
> +       };
> +};
> +
> +
> +&qspi {
> +       status = "okay";
> +       flash0: n25q512a at 0 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "st,m25p80";
> +               spi-max-frequency = <20000000>;
> +               reg = <0>;
> +       };
> +       flash1: n25q512a at 1 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "st,m25p80";
> +               spi-max-frequency = <20000000>;
> +               reg = <0>;
> +       };
> +};
> +
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> --
> 1.7.4.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
- Leo
