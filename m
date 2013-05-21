From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 21 May 2013 10:17:20 +0800
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <4003326.AbobOukrYT@wuerfel>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <201305171429.52646.arnd@arndb.de>
 <20130517130603.GJ8607@S2101-09.ap.freescale.net>
 <4003326.AbobOukrYT@wuerfel>
Message-ID: <20130521021718.GA3080@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 03:17:31PM +0200, Arnd Bergmann wrote:
> On Friday 17 May 2013 21:06:05 Shawn Guo wrote:
> > On Fri, May 17, 2013 at 02:29:52PM +0200, Arnd Bergmann wrote:
> > > > > Actually I think you should move that driver to drivers/clk and use
> > > > > of_clk_init(NULL) to initialize it.
> > > > > 
> > > > The mvf600 clock driver uses a lot of base clk support from mach-imx,
> > > > and can not be moved into drivers/clk as a single driver.  Right now, in
> > > > IMX clock drivers, we call of_clk_init() to only register fixed rate
> > > > clocks, since all the other clocks are not represented in device tree.
> > > 
> > > What are your plans for this in the long run?
> > > 
> > We can move all the IMX clock drivers into drivers/clk at some point
> > when necessary.  But I do not have a plan to register all the clocks
> > by merely calling of_clk_init(), because doing that would mean we have
> > to represent all these clocks in device tree.  For imx6q example, it's
> > about 200 ~ 300 nodes addition to DTB.  Device tree maintainers are
> > against to the idea.  They are perfectly fine with having clock driver
> > in kernel to represent/register these SoC internal clocks to clk
> > framework.
> 
> Can't we move the driver to drivers/clk and have it initialized through
> of_clk_init() without representing all clocks in the DT?

Sorry.  I just get aware of that I misunderstood your comment.  Yes,
declaring the clock initialization function with CLK_OF_DECLARE(),
we can use of_clk_init() to have them invoked properly.  I just sent a
patch to change imx6 clock driver to do that.

Shawn
