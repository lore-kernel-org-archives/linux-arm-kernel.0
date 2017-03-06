From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Mon, 6 Mar 2017 22:49:05 +0100
Subject: [PATCH v8 6/6] arm64: dts: allwinner: h5: add support for the
 Orange Pi PC 2 board
In-Reply-To: <20170306171750.7491-7-icenowy@aosc.xyz>
References: <20170306171750.7491-1-icenowy@aosc.xyz>
 <20170306171750.7491-7-icenowy@aosc.xyz>
Message-ID: <20170306214904.o2zpw3q3fvtrmsmd@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 01:17:50AM +0800, Icenowy Zheng wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> 
> The Orange Pi PC 2 is a typical single board computer using the
> Allwinner H5 SoC. Apart from the usual suspects it features three
> separately driven USB ports and a Gigabit Ethernet port.
> Also it has a SPI NOR flash soldered, from which the board can boot
> from. This enables the SBC to behave like a "real computer" with
> built-in firmware.
> 
> Add the board specific .dts file, which includes the H5 .dtsi and
> enables the peripherals that we support so far.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> [Icenowy: dropped all GPIO pinctrl nodes, change red LED gpio,
>  change MMC cd to active-low, rename some node names to prevent
>  underscores]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Reviewed-by: Rask Ingemann Lambertsen <rask@formelder.dk>

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> new file mode 100644
> index 000000000000..30639729920d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> @@ -0,0 +1,163 @@
> +/*
> + * Copyright (C) 2016 ARM Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.

I didn't catch any sort of announcement of it, but it seems as if we've
started using SPDX license identifiers in dts files. Thus you can simply
include the line
SPDX-License-Identifier: (GPL-2.0+ OR MIT)
after the copyright notice and omit the license notices themselves. Even
though the comment refers to "the X11 license", the license text matches that
associated with the MIT license identifier [1] rather than that of the X11
license [2]. The same goes for patch 5/6.

[1] https://spdx.org/licenses/MIT.html#licenseText
[2] https://spdx.org/licenses/X11.html#licenseText

-- 
Rask Ingemann Lambertsen
