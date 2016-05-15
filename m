From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 15 May 2016 21:18:32 +0200
Subject: [PATCH 15/16] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <20160509093958.26e9549f8ce78888c0e9586a@free.fr>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
 <20160509093958.26e9549f8ce78888c0e9586a@free.fr>
Message-ID: <20160515191832.GE27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 09:39:58AM +0200, Jean-Francois Moine wrote:
> On Sun,  8 May 2016 22:01:50 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Add the list of clocks and resets found in the H3 CCU.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi-ng/Makefile        |   2 +
> >  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  | 757 +++++++++++++++++++++++++++++++++++
> >  include/dt-bindings/clock/sun8i-h3.h | 162 ++++++++
> >  include/dt-bindings/reset/sun8i-h3.h | 103 +++++
> >  4 files changed, 1024 insertions(+)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> >  create mode 100644 include/dt-bindings/clock/sun8i-h3.h
> >  create mode 100644 include/dt-bindings/reset/sun8i-h3.h
> > 
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> > index c794f57b6fb1..67ff6a92f124 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -13,3 +13,5 @@ obj-y += ccu_nkmp.o
> >  obj-y += ccu_nm.o
> >  obj-y += ccu_p.o
> >  obj-y += ccu_phase.o
> > +
> > +obj-y += ccu-sun8i-h3.o
> 
> +obj-$(CONFIG_MACH_SUN8I) += ccu-sun8i-h3.o
> 
> should be better.

Indeed, changed.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160515/bfedb768/attachment-0001.sig>
