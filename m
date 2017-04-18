From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Apr 2017 09:08:31 +0200
Subject: [PATCH v3 10/12] arm64: allwinner: a64: add DTSI file for AXP803
 PMIC
In-Reply-To: <20170417115747.7300-11-icenowy@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-11-icenowy@aosc.io>
Message-ID: <20170418070831.pt6fj6hufaoboiqv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 07:57:45PM +0800, Icenowy Zheng wrote:
> As nearly all A64 boards are using AXP803 PMIC, add a DTSI file for it,
> like the old DTSI files for AXP20x/22x, for the common parts of the
> PMIC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 150 ++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/axp803.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> new file mode 100644
> index 000000000000..f0e53a7fffbd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -0,0 +1,150 @@
> +/*
> + * Copyright 2017 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
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
> +/*
> + * AXP803 Integrated Power Management Chip
> + * http://files.pine64.org/doc/datasheet/pine64/AXP803_Datasheet_V1.0.pdf
> + */
> +
> +&axp803 {
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	regulators {
> +		/* Default work frequency for buck regulators */
> +		x-powers,dcdc-freq = <3000>;
> +
> +		reg_dcdc1: dcdc1 {
> +			regulator-name = "dcdc1";
> +		};
> +
> +		reg_dcdc2: dcdc2 {
> +			regulator-name = "dcdc2";
> +		};
> +
> +		reg_dcdc3: dcdc3 {
> +			regulator-name = "dcdc3";
> +		};
> +
> +		reg_dcdc4: dcdc4 {
> +			regulator-name = "dcdc4";
> +		};
> +
> +		reg_dcdc5: dcdc5 {
> +			regulator-name = "dcdc5";
> +		};
> +
> +		reg_dcdc6: dcdc6 {
> +			regulator-name = "dcdc6";
> +		};
> +
> +		reg_dc1sw: dc1sw {
> +			regulator-name = "dc1sw";
> +		};
> +
> +		reg_aldo1: aldo1 {
> +			regulator-name = "aldo1";
> +		};
> +
> +		reg_aldo2: aldo2 {
> +			regulator-name = "aldo2";
> +		};
> +
> +		reg_aldo3: aldo3 {
> +			regulator-name = "aldo3";
> +		};

Please sort them by alphabetical order.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/ff425dc6/attachment.sig>
