From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 14:19:26 +0200
Subject: [PATCH 2/5] ARM: sun5i: Add R8 DTSI
In-Reply-To: <CAGb2v64Zx-H5L456ybjEFz-sPDy_xhO=Lxua6CFj9Dg+6y=vqQ@mail.gmail.com>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442566130-3497-3-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64Zx-H5L456ybjEFz-sPDy_xhO=Lxua6CFj9Dg+6y=vqQ@mail.gmail.com>
Message-ID: <20150918121926.GP4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 05:41:47PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Sep 18, 2015 at 4:48 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The R8 is very close to the A13, but it still has a few differences,
> > notably a composite output, which the A13 lacks.
> >
> > Add a DTSI based on the A13's to hold those differences.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun5i-r8.dtsi | 61 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun5i-r8.dtsi
> >
> > diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/sun5i-r8.dtsi
> > new file mode 100644
> > index 000000000000..c9ed854687ca
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun5i-r8.dtsi
> > @@ -0,0 +1,61 @@
> > +/*
> > + * Copyright 2015 Free Electrons
> > + * Copyright 2015 NextThing Co
> > + *
> > + * Maxime Ripard <maxime.ripard@free-electrons.com>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of the
> > + *     License, or (at your option) any later version.
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
> > +#include "skeleton.dtsi"
> 
> This is already included by sun5i.dtsi, which is included by
> sun5i-a13.dtsi.

Ah, yes.

> > +
> > +#include "sun5i-a13.dtsi"
> > +
> > +/ {
> > +       chosen {
> > +               framebuffer at 1 {
> > +                       compatible = "allwinner,simple-framebuffer",
> > +                                    "simple-framebuffer";
> > +                       allwinner,pipeline = "de_be0-lcd0-tve0";
> > +                       clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
> > +                                <&ahb_gates 44>;
> > +                       status = "disabled";
> > +               };
> > +       };
> > +};
> > --
> > 2.5.1
> >
> 
> The rest looks good.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/0dbfe589/attachment.sig>
