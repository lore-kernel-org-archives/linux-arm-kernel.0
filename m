From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 29 Feb 2016 12:21:39 +0100
Subject: [PATCHv2 16/16] ARM: dts: imx6ul: add support for Ka-Ro
 electronics TXUL modules
In-Reply-To: <20160228064326.GG22051@tiger>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-17-git-send-email-LW@KARO-electronics.de>
 <20160228064326.GG22051@tiger>
Message-ID: <20160229122139.6a560304@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, 28 Feb 2016 14:43:26 +0800 Shawn Guo wrote:
> On Wed, Jan 20, 2016 at 11:09:09AM +0100, Lothar Wa?mann wrote:
[...]
> > +/dts-v1/;
> > +#include "imx6ul.dtsi"
> > +#include "imx6ul-txul.dtsi"
> > +
> > +/ {
> > +	model = "Ka-Ro electronics TXUL-0010 Module";
> > +	compatible = "karo,imx6ul-tx6ul", "fsl,imx6ul";
> > +
> > +	aliases {
> > +		mmc0 = &usdhc1;
> > +		/delete-property/ mmc1;
> 
> Why is this deletion of mmc1 needed?
> 
Its not actually necessary, but for convenience of U-Boot users who may
want to enable/disable the mmc interface dynamically. Since the
USDHC2 interface is not available on this module, I prefer not to have
a dangling alias that points to an interface that is not actually
useable.

> > diff --git a/arch/arm/boot/dts/imx6ul-txul-0011.dts b/arch/arm/boot/dts/imx6ul-txul-0011.dts
> > new file mode 100644
> > index 0000000..dd3055b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6ul-txul-0011.dts
> > @@ -0,0 +1,85 @@
> > +/*
> > + * Copyright 2015 Lothar Wa?mann <LW@KARO-electronics.de>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License
> > + *     version 2 as published by the Free Software Foundation.
> > + *
> > + *     This file is distributed in the hope that it will be useful,
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
> > +#include "imx6ul.dtsi"
> > +#include "imx6ul-txul.dtsi"
> > +
> > +/ {
> > +	model = "Ka-Ro electronics TXUL-0011 Module";
> > +	compatible = "karo,imx6ul-tx6ul", "fsl,imx6ul";
> > +
> > +	aliases {
> > +		mmc0 = &usdhc2;
> > +		mmc1 = &usdhc1;
> > +	};
> > +};
> > +
> > +&gpmi {
> > +	status = "disabled";
> > +};
> > +
> > +&iomuxc {
> > +	imx6ul-txul {
> 
> Since commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without
> function nodes), we can save this container node.
> 
I already reworked the file in the meantime, so that this and your
remaining comments are addressed.


Lothar Wa?mann
