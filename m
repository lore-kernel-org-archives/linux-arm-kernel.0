From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 16 Apr 2012 12:56:48 +0200
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416103822.GU24211@n2100.arm.linux.org.uk>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
Message-ID: <20120416105648.GA414@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 11:38:22AM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 16, 2012 at 04:00:53PM +0530, Viresh Kumar wrote:
> > On 4/16/2012 3:55 PM, Domenico Andreoli wrote:
> > > On Mon, Apr 16, 2012 at 10:49:37AM +0530, Viresh Kumar wrote:
> > >> From: Russell King <rmk+kernel@arm.linux.org.uk>
> > >> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> > >> +int clk_register_single_clkdev(struct clk *clk, const char *dev_id,
> > >> +		const char *con_id)
> > >> +{
> > >> +	struct clk_lookup *cl;
> > >> +
> > >> +	if (!clk || (!dev_id && !con_id))
> > >> +		return -ENOMEM;
> > > 
> > > I would return -EINVAL here.
> > 
> > Will fix it.
> 
> Do we actually need this kind of check?
> 
> > >> +int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num)
> > >> +{
> > >> +	unsigned i;
> > >> +
> > >> +	if (!clk || !cl || !num)
> > >> +		return -ENOMEM;
> > > 
> > > I would return -EINVAL here as well.
> > 
> > Will fix this too.
> 
> Ditto.
> 
> I don't think these checks actually help anyone, especially if the user
> forgets to check the return value (which makes them silent errors.)
> 
> If you're going to abuse the interface by passing a NULL clk_lookup or
> num=0 then you deserve to get a big fat oops to tell you that you messed
> up.  Same for NULL dev_id and con_id above.

I hope for a BUG_ON then.

cheers,
Domenico
