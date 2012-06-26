From: marex@denx.de (Marek Vasut)
Date: Tue, 26 Jun 2012 14:16:11 +0200
Subject: [PATCH 4/7] ARM: mxs: Add SPI clock into clk framwork
In-Reply-To: <20120626065428.GM2342@S2101-09.ap.freescale.net>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
 <1340477033-2761-4-git-send-email-marex@denx.de>
 <20120626065428.GM2342@S2101-09.ap.freescale.net>
Message-ID: <201206261416.11599.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sat, Jun 23, 2012 at 08:43:50PM +0200, Marek Vasut wrote:
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Detlev Zundel <dzu@denx.de>
> > CC: Dong Aisheng <b29396@freescale.com>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > CC: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > Cc: Wolfgang Denk <wd@denx.de>
> > ---
> > 
> >  drivers/clk/mxs/clk-imx28.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> > index 003b0f3..d22b926 100644
> > --- a/drivers/clk/mxs/clk-imx28.c
> > +++ b/drivers/clk/mxs/clk-imx28.c
> > @@ -149,21 +149,25 @@ static struct clk_lookup xbus_lookups[] __initdata
> > = {
> > 
> >  static struct clk_lookup ssp0_lookups[] __initdata = {
> >  
> >  	{ .dev_id = "imx28-mmc.0", },
> > 
> > +	{ .dev_id = "imx28-spi.0", },
> > 
> >  	{ .dev_id = "80010000.ssp", },
> >  
> >  };
> >  
> >  static struct clk_lookup ssp1_lookups[] __initdata = {
> >  
> >  	{ .dev_id = "imx28-mmc.1", },
> > 
> > +	{ .dev_id = "imx28-spi.1", },
> > 
> >  	{ .dev_id = "80012000.ssp", },
> >  
> >  };
> >  
> >  static struct clk_lookup ssp2_lookups[] __initdata = {
> >  
> >  	{ .dev_id = "imx28-mmc.2", },
> > 
> > +	{ .dev_id = "imx28-spi.2", },
> > 
> >  	{ .dev_id = "80014000.ssp", },
> >  
> >  };
> >  
> >  static struct clk_lookup ssp3_lookups[] __initdata = {
> >  
> >  	{ .dev_id = "imx28-mmc.3", },
> > 
> > +	{ .dev_id = "imx28-spi.3", },
> > 
> >  	{ .dev_id = "80016000.ssp", },
> >  
> >  };
> 
> These changes should not be needed, as the driver will only be probed
> from device tree.

So why are those imx28-mmc there ? Shall these not be removed then ?

Best regards,
Marek Vasut
