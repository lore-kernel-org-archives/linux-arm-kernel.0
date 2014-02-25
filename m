From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 11:07:30 -0500
Subject: [PATCH] watchdog: orion_wdt: Use %pa to print 'phys_addr_t'
In-Reply-To: <20140225150947.GA22740@localhost>
References: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
 <20140224203352.GA21204@spo001.leaseweb.com>
 <20140225150947.GA22740@localhost>
Message-ID: <20140225160729.GK1010@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 12:09:48PM -0300, Ezequiel Garcia wrote:
> Jason,
> 
> On Mon, Feb 24, 2014 at 09:33:52PM +0100, Wim Van Sebroeck wrote:
> > > When building an ARM multi_v7_defconfig with LPAE option selected we get the
> > > following build warning:
> > > 
> > > drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wformat=]
> > > 
> > > Fix it by using %pa to print 'phys_addr_t'.
> > > 
> > > Reported-by: Olof's autobuilder <build@lixom.net>
> > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > > ---
> > >  drivers/watchdog/orion_wdt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> > > index 15321aa..6f9b4c6 100644
> > > --- a/drivers/watchdog/orion_wdt.c
> > > +++ b/drivers/watchdog/orion_wdt.c
> > > @@ -269,7 +269,7 @@ static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
> > >  
> > >  	rstout = internal_regs + ORION_RSTOUT_MASK_OFFSET;
> > >  
> > > -	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg 0x%x\n", rstout);
> > > +	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rstout);
> > >  	return devm_ioremap(&pdev->dev, rstout, 0x4);
> > >  }
> > >  
> > > -- 
> > > 1.8.1.2
> > > 
> > > 
> > 
> > Acked-by me also, but can this also go via the mvebu tree (since the patch that introduces this is also there??
> > 
> 
> Can you pull this too? It's been acked by Wim and me.

Yep, I'll add it onto the stack.

thx,

Jason.
