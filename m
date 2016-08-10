From: kbeldan@baylibre.com (Karl Beldan)
Date: Wed, 10 Aug 2016 07:27:44 +0000
Subject: [PATCH 1/4] memory: ti-aemif: Get a named clock rather than an
 unnamed one
In-Reply-To: <20160810070019.GA14114@gobelin>
References: <20160809171518.22690-1-kbeldan@baylibre.com>
 <20160809171518.22690-2-kbeldan@baylibre.com>
 <20160810070019.GA14114@gobelin>
Message-ID: <20160810072744.GA24903@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 07:00:20AM +0000, Karl Beldan wrote:
> On Tue, Aug 09, 2016 at 05:15:15PM +0000, Karl Beldan wrote:
> > Many davinci boards (da830 and da850 families) don't have their clocks
> > in DT yet and won't be successful in getting an unnamed aemif clock.
> > Also the sole current users of ti-aemif (keystone boards) use 'aemif' as
> > their aemif device clock clock-name and should remain unaffected.
> > 
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> > ---
> >  drivers/memory/ti-aemif.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> > index a579a0f..c251fc8 100644
> > --- a/drivers/memory/ti-aemif.c
> > +++ b/drivers/memory/ti-aemif.c
> > @@ -345,7 +345,7 @@ static int aemif_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, aemif);
> >  
> > -	aemif->clk = devm_clk_get(dev, NULL);
> > +	aemif->clk = devm_clk_get(dev, "aemif");
> 
> Looking further it seems to me that the struct clk_lookup da850_clks
> registered by davinci_clk_init() should be enough to clk_get() unnamed
> clocks using only the dev name. I look into what's going on but it
> would make this patch unnecessary.
>  
Ok, just saw what's happening, this patch is unnecessary, v2 will
follow.
 
Karl
