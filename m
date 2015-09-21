From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 21 Sep 2015 10:19:37 +0800
Subject: [PATCH 3/3] arm64: dts: add dts file for Marvell Berlin4CT STB
 board
In-Reply-To: <55FF03AB.4000209@gmail.com>
References: <1442584059-7319-1-git-send-email-jszhang@marvell.com>
 <1442584059-7319-4-git-send-email-jszhang@marvell.com>
 <55FF03AB.4000209@gmail.com>
Message-ID: <20150921101937.0e47d0d8@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Sep 2015 21:06:19 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 18.09.2015 15:47, Jisheng Zhang wrote:
> > This patch adds dts for the Berlin4CT STB reference board which is also
> > based on the Berlin4CT SoC. The Berlin4CT DMP board will be deprecated as
> > time goes.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >   arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 66 +++++++++++++++++++++++++++
> 
> This is missing the corresponding Makefile change to add the
> board to the default dtb build list.

oops, sorry, I missed it.

> 
> I've fixed it up and
> 
> Applied the two dts patches to berlin64/dt

Thanks a lot ;)

> 
> Sebastian
> 
> >   1 file changed, 66 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
> >
> > diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
> > new file mode 100644
> > index 0000000..348c37e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
> > @@ -0,0 +1,66 @@
> > +/*
> > + * Copyright (C) 2015 Marvell Technology Group Ltd.
> > + *
> > + * Author: Jisheng Zhang <jszhang@marvell.com>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPLv2 or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This library is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This library is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall be
> > + *     included in all copies or substantial portions of the Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "berlin4ct.dtsi"
> > +
> > +/ {
> > +	model = "Marvell BG4CT STB board";
> > +	compatible = "marvell,berlin4ct-stb", "marvell,berlin4ct", "marvell,berlin";
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		/* the first 16MB is for firmwares' usage */
> > +		reg = <0 0x01000000 0 0x7f000000>;
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	status = "okay";
> > +};
> >
> 
