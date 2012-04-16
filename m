From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Mon, 16 Apr 2012 23:12:32 +0200
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416210617.GA22932@glitch>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
 <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
 <20120416205655.GJ20478@pengutronix.de>
 <20120416210617.GA22932@glitch>
Message-ID: <20120416211232.GL20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 11:06:18PM +0200, Domenico Andreoli wrote:
> > >  - allocate and add single clkdev for a single clk structure.
> > >  - add multiple clkdevs for a single clk structure.
> > > 
> > > +
> > > +int clk_register_single_clkdev(struct clk *clk, const char *con_id,
> > > +		const char *dev_fmt, ...)
> > 
> > Can we drop the 'single' in the name? Otherwise it's quite a long
> > function name. I think name clk_register_clkdev makes it clear already
> > that we only register a single clkdev.
> 
> clkdev_register?

Maybe even this. I just though that it might be too easy to confuse with
clkdev_add (In fact I think clkdev_register would be a good name for
what clkdev_add currently does, but it's probably not worth the churn
changing this).

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
