From: mturquette@ti.com (Mike Turquette)
Date: Wed, 27 Jun 2012 10:49:11 -0700
Subject: [PATCH] clk: mxs: add clkdev lookup for pwm
In-Reply-To: <20120627133239.GC9787@S2101-09.ap.freescale.net>
References: <1340701210-8547-1-git-send-email-shawn.guo@linaro.org>
 <20120627133239.GC9787@S2101-09.ap.freescale.net>
Message-ID: <20120627174911.GE22766@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120627-21:32, Shawn Guo wrote:
> Mike,
> 
> I queued this one on my clk/mxs-for-3.6 branch together with another
> couple of clk/mxs patches, and will send you a pull-request at a later
> time.
> 

Shawn,

OK great.  This patch looks fine to me and I finally got a branch into
clk-next, so just send your pull request along and I'll get it in.

Regards,
Mike

> Regards,
> Shawn
> 
> On Tue, Jun 26, 2012 at 05:00:10PM +0800, Shawn Guo wrote:
> > Add pwm clock lookup for imx23 and imx28 booting from device tree.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/clk/mxs/clk-imx23.c |    1 +
> >  drivers/clk/mxs/clk-imx28.c |    1 +
> >  2 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
> > index db2391c..7e03d41 100644
> > --- a/drivers/clk/mxs/clk-imx23.c
> > +++ b/drivers/clk/mxs/clk-imx23.c
> > @@ -189,6 +189,7 @@ int __init mx23_clocks_init(void)
> >  		}
> >  
> >  	clk_register_clkdev(clks[clk32k], NULL, "timrot");
> > +	clk_register_clkdev(clks[pwm], NULL, "80064000.pwm");
> >  	clk_register_clkdevs(clks[hbus], hbus_lookups, ARRAY_SIZE(hbus_lookups));
> >  	clk_register_clkdevs(clks[xbus], xbus_lookups, ARRAY_SIZE(xbus_lookups));
> >  	clk_register_clkdevs(clks[uart], uart_lookups, ARRAY_SIZE(uart_lookups));
> > diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> > index 7fad6c8..e3f6ea9 100644
> > --- a/drivers/clk/mxs/clk-imx28.c
> > +++ b/drivers/clk/mxs/clk-imx28.c
> > @@ -314,6 +314,7 @@ int __init mx28_clocks_init(void)
> >  
> >  	clk_register_clkdev(clks[clk32k], NULL, "timrot");
> >  	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
> > +	clk_register_clkdev(clks[pwm], NULL, "80064000.pwm");
> >  	clk_register_clkdevs(clks[hbus], hbus_lookups, ARRAY_SIZE(hbus_lookups));
> >  	clk_register_clkdevs(clks[xbus], xbus_lookups, ARRAY_SIZE(xbus_lookups));
> >  	clk_register_clkdevs(clks[uart], uart_lookups, ARRAY_SIZE(uart_lookups));
> > -- 
> > 1.7.5.4
> > 
> > 
> 
