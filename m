From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 20 Nov 2018 15:26:19 +0200
Subject: [PATCH] clk: Add (devm_)clk_get_optional() functions
In-Reply-To: <20181120125652.afk2rltmnunfo346@pengutronix.de>
References: <20181119141259.11992-1-phil.edworthy@renesas.com>
 <20181120103832.GV10650@smile.fi.intel.com>
 <20181120125652.afk2rltmnunfo346@pengutronix.de>
Message-ID: <20181120132619.GY10650@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 01:56:52PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Nov 20, 2018 at 12:38:33PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 19, 2018 at 02:12:59PM +0000, Phil Edworthy wrote:
> > > +	if (clk == ERR_PTR(-ENOENT))
> > > +		return NULL;
> > > +	else
> > > +		return clk;
> > 
> > return clk == ERR_PTR(-ENOENT) ? NULL : clk;
> > 
> > ?
> 
> Not sure this adds to the readability of the expression. Personally I
> prefer the explicit if. Maybe even:
> 
> 	clk = clk_get(...);
> 
> 	if (clk == ERR_PTR(-ENOENT))
> 		clk = NULL;
> 
> 	return clk;

So, it almost repeats the initial variant.
I'm fine with no 'else' in initial code, like

if (...)
	return NULL;

return clk;


-- 
With Best Regards,
Andy Shevchenko
