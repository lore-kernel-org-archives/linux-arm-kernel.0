From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Sun, 7 Jan 2018 17:26:49 +0100
Subject: [PATCH 6/7] arm64: allwinner: h6: add the basical Allwinner H6
 DTSI file
In-Reply-To: <20180106050910.48070-1-icenowy@aosc.io>
References: <20180106050910.48070-1-icenowy@aosc.io>
Message-ID: <CAOFm3uHVsXTMPmrx2G-5vR6oiYk5Fq0qQXfGpT3NrUJwumRweQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 6, 2018 at 6:09 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner H6 is a new SoC with Cortex-A53 cores from Allwinner, with its
> memory map fully reworked and some high-speed peripherals (PCIe, USB
> 3.0) introduced.
>
> This commit adds the basical DTSI file of it, including the clock
> support and UART support.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 214 +++++++++++++++++++++++++++
>  1 file changed, 214 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> new file mode 100644
> index 000000000000..482f5cb64d07
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -0,0 +1,214 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
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

Icenowy,
This is a very long legalese indeed!
Do you mind using the new concise SPDX tags instead here and in the
rest of your patch?
See Thomas doc [1]
Thanks!

[1] https://lkml.org/lkml/2017/12/28/323
-- 
Cordially
Philippe Ombredanne
