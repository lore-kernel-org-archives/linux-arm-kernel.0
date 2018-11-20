From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 Nov 2018 13:56:52 +0100
Subject: [PATCH] clk: Add (devm_)clk_get_optional() functions
In-Reply-To: <20181120103832.GV10650@smile.fi.intel.com>
References: <20181119141259.11992-1-phil.edworthy@renesas.com>
 <20181120103832.GV10650@smile.fi.intel.com>
Message-ID: <20181120125652.afk2rltmnunfo346@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 20, 2018 at 12:38:33PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 19, 2018 at 02:12:59PM +0000, Phil Edworthy wrote:
> > +	if (clk == ERR_PTR(-ENOENT))
> > +		return NULL;
> > +	else
> > +		return clk;
> 
> return clk == ERR_PTR(-ENOENT) ? NULL : clk;
> 
> ?

Not sure this adds to the readability of the expression. Personally I
prefer the explicit if. Maybe even:

	clk = clk_get(...);

	if (clk == ERR_PTR(-ENOENT))
		clk = NULL;

	return clk;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
