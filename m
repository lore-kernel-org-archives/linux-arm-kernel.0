From: robh@kernel.org (Rob Herring)
Date: Mon, 15 May 2017 15:56:57 -0500
Subject: [PATCH v3 9/9] arm: dts: mt7623: add dts file for Bananapi R2
 (BPI-R2) board
In-Reply-To: <0beebd0e209b4caeb349a062be7ef245d0689fb6.1494574682.git.sean.wang@mediatek.com>
References: <cover.1494574682.git.sean.wang@mediatek.com>
 <0beebd0e209b4caeb349a062be7ef245d0689fb6.1494574682.git.sean.wang@mediatek.com>
Message-ID: <20170515205657.5dpt3smakpvwzgp4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 03:56:46PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add support for the Bananapi R2 (BPI-R2) development board from
> BIPAI KEJI. Detailed hardware information for BPI-R2 which could be
> found on http://www.banana-pi.org/r2.html
> 
> The patch currently only adds Mediatek GMAC, MT7530 Switch, the crypto
> engine, USB, IR, I2S, I2C, UART, SPI, PWM, GPIO keys, GPIO LEDs and
> PMIC LEDs. As to the other missing hardware and peripherals, they would
> be added and integrated continuously.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt |   2 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      | 478 +++++++++++++++++++++
>  3 files changed, 481 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> index 412c6bd..7b289bd 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> @@ -42,6 +42,8 @@ Supported boards:
>  - Reference  board for MT7623n with NAND:
>      Required root node properties:
>        - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
> +- Bananapi BPI-R2 board:
> +      - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
>  - MTK mt8127 tablet moose EVB:
>      Required root node properties:
>        - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 20a7c9d..34eb03f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1035,6 +1035,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  	mt6589-aquaris5.dtb \
>  	mt6592-evb.dtb \
>  	mt7623n-rfb-nand.dtb \
> +	mt7623n-bananapi-bpi-r2.dtb \
>  	mt8127-moose.dtb \
>  	mt8135-evbp1.dtb
>  dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> new file mode 100644
> index 0000000..cb1bd20
> --- /dev/null
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -0,0 +1,478 @@
> +/*
> + * Copyright 2017 Sean Wang <sean.wang@mediatek.com>
> + *
> + * Sean Wang <sean.wang@mediatek.com>
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

You can use SPDX tag here if you like:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Regardless,

Acked-by: Rob Herring <robh@kernel.org> 
