From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 18 Apr 2011 15:54:35 +0200
Subject: [PATCH 06/10] clk: Add support for a generic clock multiplexer
In-Reply-To: <20110418133353.GL14770@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-7-git-send-email-s.hauer@pengutronix.de>
	<20110418131527.GF31131@pengutronix.de>
	<20110418133353.GL14770@pengutronix.de>
Message-ID: <20110418135435.GI31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 03:33:53PM +0200, Sascha Hauer wrote:
> On Mon, Apr 18, 2011 at 03:15:27PM +0200, Uwe Kleine-K?nig wrote:
> > On Fri, Apr 15, 2011 at 09:08:11PM +0200, Sascha Hauer wrote:
> > > +
> > > +static int clk_mux_set_parent(struct clk *clk, struct clk *parent)
> > > +{
> > > +	struct clk_mux *mux = to_clk_mux(clk);
> > > +	u32 val;
> > > +	int i;
> > > +	unsigned long flags = 0;
> > = 0 isn't needed. (Or does gcc wail without it?)
> 
> At least my gcc is not smart engough for this. flags may be used unitialized.
Then please use

	unsigned long uninitialized_var(flags);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
