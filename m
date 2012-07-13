From: mturquette@ti.com (Mike Turquette)
Date: Fri, 13 Jul 2012 10:27:04 -0700
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <50003A6F.5090008@gmail.com>
References: <20120713151451.b2ef97045ef2273ea15973c9@canb.auug.org.au>
 <50003A6F.5090008@gmail.com>
Message-ID: <20120713172704.GO2772@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120713-10:10, Rob Herring wrote:
> 
> 
> On 07/13/2012 12:14 AM, Stephen Rothwell wrote:
> > Hi Mike,
> > 
> > Today's linux-next merge of the clk tree got a conflict in
> > drivers/clk/Makefile between commit 4a31bd28e86a ("ARM: nomadik: convert
> > to generic clock") from the arm-soc tree and commit 8d4d9f52081c ("clk:
> > add highbank clock support") from the clk tree.
> > 
> > Just context changes.  I fixed it up (see below) and can carry the fix as
> > necessary.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell                    sfr at canb.auug.org.au
> > 
> > diff --cc drivers/clk/Makefile
> > index 26b6b92,02ffdf6..0000000
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@@ -3,6 -3,11 +3,12 @@@ obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.
> >   obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
> >   				   clk-mux.o clk-divider.o clk-fixed-factor.o
> >   # SoCs specific
> >  +obj-$(CONFIG_ARCH_NOMADIK)	+= clk-nomadik.o
> > + obj-$(CONFIG_ARCH_HIGHBANK)	+= clk-highbank.o
> >   obj-$(CONFIG_ARCH_MXS)		+= mxs/
> >   obj-$(CONFIG_PLAT_SPEAR)	+= spear/
> > + obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
> > + obj-$(CONFIG_ARCH_INTEGRATOR)	+= versatile/
> 
> These should be sorted.
> 

Hi Rob,

Did something change in the arm-soc tree to resolve this conflict?
Nothing changed in clk-next.

Thanks,
Mike

> Rob
> 
> > + 
> > + # Chip specific
> > + obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
