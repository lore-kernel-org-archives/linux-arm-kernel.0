From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 04 Sep 2012 12:53:22 +0100
Subject: [PATCH 06/11] clk: Common clocks implementation for Versatile
 Express
In-Reply-To: <201209032124.02224.arnd@arndb.de>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-7-git-send-email-pawel.moll@arm.com>
 <201209032124.02224.arnd@arndb.de>
Message-ID: <1346759602.2605.69.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-09-03 at 22:24 +0100, Arnd Bergmann wrote:
> On Monday 03 September 2012, Pawel Moll wrote:
> > +void __init vexpress_clk_init(void __iomem *sp810_base)
> > +{
> > +       struct clk *clk;
> > +       int i;
> > +
> > +       clk = clk_register_fixed_rate(NULL, "dummy_apb_pclk", NULL,
> > +                       CLK_IS_ROOT, 0);
> > +       WARN_ON(clk_register_clkdev(clk, "apb_pclk", NULL));
> > +
> 
> Isn't it time to just remove the non-DT parts of vexpress? That would
> also simplify this driver.

It would simplify not only this driver, but the whole infrastructure
indeed. But we are still "CLCD driver away" from the full features
replacement. Ryan Harkin is working on this, but it doesn't look like he
was going to make it in time for 3.7. A second after this happens I'll
post a "big kill" patch removing all non-DT stuff - I'm really looking
forward to it :-)

Pawel
