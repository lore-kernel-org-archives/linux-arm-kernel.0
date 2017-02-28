From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 28 Feb 2017 17:14:59 -0600
Subject: [PATCH] arm64: dts: allwinner: add support for Pinebook
In-Reply-To: <20170225070032.35834-1-icenowy@aosc.xyz>
References: <20170225070032.35834-1-icenowy@aosc.xyz>
Message-ID: <CAL_JsqJ_Z+1gG1A7wRB16ApyY0=xkkjRNDkGPMAhVx3gF6PwcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 1:00 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Pinebook is a A64-based laptop produced by Pine64, with the following
> peripherals:
>
> USB:
> - Two external USB ports (one is directly connected to A64's OTG
> controller, the other is under a internal hub connected to the host-only
> controller.)
> - USB HID keyboard and touchpad connected to the internal hub.
> - USB UVC camera connected to the internal hub.
>
> Power-related:
> - A DC IN jack connected to AXP803's DCIN pin.
> - A Li-Polymer battery connected to AXP803's battery pins.
>
> Storage:
> - An eMMC by Foresee on the main board (in the product revision of the
> main board it's designed to be switchable).
> - An external MicroSD card slot.
>
> Display:
> - An eDP LCD panel (1366x768) connected via an ANX6345/ANX9807 RGB-eDP
> bridge.
> - A mini HDMI jack.
>
> Misc:
> - A Hall sensor designed to detect the status of lid, connected to GPIO PH10.
> - A headphone jack connected to the SoC's internal codec.
> - A BMA223 gravity sensor connected to the SoC's I2C1 bus. (Not
> supported yet)
> - A debug UART port muxed with one of the USB ports, only available on
> product revision of the main board.
>
> This commit adds basical support for it, with out-of-tree patches for
> display support the laptop can be basically usable.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  .../boot/dts/allwinner/sun50i-a64-pinebook.dts     | 123 +++++++++++++++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index bc6f342be59f..893520c39955 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinebook.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>
>  always         := $(dtb-y)
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> new file mode 100644
> index 000000000000..2dceba3132b0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -0,0 +1,123 @@
> +/*
> + * Copyright (c) 2016 ARM Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
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

Use SPDX tags here:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

While it says X11, this is really MIT license text.
