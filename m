From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Aug 2017 12:04:09 +0200
Subject: [PATCH v2] arm64: dts: rockchip: add rk3328-rock64 board
In-Reply-To: <20170817202029.iset3te4zvb4jhfo@rob-hp-laptop>
References: <20170811232947.18698-1-heiko@sntech.de>
 <20170817202029.iset3te4zvb4jhfo@rob-hp-laptop>
Message-ID: <3137651.GzLSZkl6sq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. August 2017, 15:20:29 CEST schrieb Rob Herring:
> On Sat, Aug 12, 2017 at 01:29:47AM +0200, Heiko Stuebner wrote:

> > +/*
> > + * Copyright (c) 2017 PINE64
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
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
> 
> Use SPDX tags here instead if you want.

There was opposition against using SPDX in the past [0] and
arm-soc maintainers didn't have a fixed opinion on this, so I decided
to stick with real license headers for Rockchip devicetrees for the
time being and/or until consensus is reached :-) .


[0] https://lkml.org/lkml/2017/2/28/750

[...]

> > +	mmc-pwrseq = <&sdio_pwrseq>;
> > +	non-removable;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
> > +	status = "disabled";
> 
> Normally, this is disabled in the SOC dts and enabled here.

yeah, somehow I'm missing some things when trying to clean up a
vendor-devicetree myself, I would normally find when reviewing a
sent in one. Will fix that.


Heiko
