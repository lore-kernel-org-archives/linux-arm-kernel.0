From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Aug 2015 14:31:59 +0200
Subject: [PATCH 2/6] ARM: dts: sunxi: Add dtsi for AXP221 PMIC
In-Reply-To: <1440755679-8266-3-git-send-email-wens@csie.org>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-3-git-send-email-wens@csie.org>
Message-ID: <20150828123159.GJ29389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 05:54:35PM +0800, Chen-Yu Tsai wrote:
> The AXP221 PMIC is used with some Allwinner SoCs. This patch adds
> a dtsi file listing all the regulator nodes. The regulators are
> initialized based on their device node names.
> 
> This can later be used with the AXP223 PMIC as well, which has
> the same functionality as AXP221, except for its host interface.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/axp221.dtsi | 148 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 arch/arm/boot/dts/axp221.dtsi
> 
> diff --git a/arch/arm/boot/dts/axp221.dtsi b/arch/arm/boot/dts/axp221.dtsi
> new file mode 100644
> index 000000000000..74836f329863
> --- /dev/null
> +++ b/arch/arm/boot/dts/axp221.dtsi
> @@ -0,0 +1,148 @@
> +/*
> + * Copyright 2015 Chen-Yu Tsai
> + *
> + * Chen-Yu Tsai <wens@csie.org>
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
> + * AXP221/221s/223 Integrated Power Management Chip
> + * http://www.x-powers.com/product/AXP22X.php
> + * http://dl.linux-sunxi.org/AXP/AXP221%20Datasheet%20V1.2%2020130326%20.pdf
> + */

I'm usually not really fond of URLs in the source code and/or the
commit logs. They tend to be broken very easily.

> +
> +&axp221 {
> +	compatible = "x-powers,axp221";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	regulators {
> +		/* Default work frequency for buck regulators */
> +		x-powers,dcdc-freq = <3000>;
> +
> +		/* supplies for dc1sw & dc5ldo are connected internally */
> +		dcdc1-supply = <&reg_dcdc1>;
> +		dcdc5-supply = <&reg_dcdc5>;

so the parent regulator of DCDC1 is DCDC1 ?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/7cfabc51/attachment-0001.sig>
