From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 May 2018 16:11:47 +0800
Subject: [PATCH 1/2] arm64: dts: ls1012a: Add FRWY-LS1012A board support
In-Reply-To: <1525760999-6187-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1525760999-6187-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <20180511081145.GD26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 11:59:58AM +0530, Bhaskar Upadhaya wrote:
> FRWY-LS1012A is a different design from LS1012A-FRDM,
> but has some common SoC features. Key feature on this
> board is Micro SD, USB 3.0, DDR, UART.
> 
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts | 64 ++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 86e18ad..d116144 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
> new file mode 100644
> index 0000000..f69086d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
> @@ -0,0 +1,64 @@
> +/*
> + * Device Tree file for NXP LS1012A FRWY Board.
> + *
> + * Copyright 2018 NXP
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
> +/dts-v1/;
> +
> +#include "fsl-ls1012a.dtsi"
> +
> +/ {
> +	model = "LS1012A FRWY Board";
> +	compatible = "fsl,frwy-ls1012a", "fsl,ls1012a";
> +
> +};
> +
> +&pcie {
> +	status = "okay";
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};

Please sort these nodes alphabetically in label name.

Shawn

> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
