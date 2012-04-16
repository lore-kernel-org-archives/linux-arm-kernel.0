From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 16 Apr 2012 23:06:18 +0200
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416205655.GJ20478@pengutronix.de>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
 <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
 <20120416205655.GJ20478@pengutronix.de>
Message-ID: <20120416210617.GA22932@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 10:56:55PM +0200, s.hauer at pengutronix.de wrote:
> On Mon, Apr 16, 2012 at 07:09:32PM +0530, viresh kumar wrote:
> > On 4/16/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > > Checking for NULL clk (or IS_ERR(clk)) and returning -ENOMEM does make
> > > sense as I mentioned in my original proposal (it allows you to pass the
> > > returned value from clk_register() directly to this function without
> > > further checking, and you get the right error code.
> > 
> > V2:
> > 
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *
> > 
> > With common clock framework, clks are allocated at runtime. Some of them require
> > clkdevs to be allocated and added in global clkdev list.
> > 
> > This patch introduces helper routines to:
> > 
> >  - allocate and add single clkdev for a single clk structure.
> >  - add multiple clkdevs for a single clk structure.
> > 
> > +
> > +int clk_register_single_clkdev(struct clk *clk, const char *con_id,
> > +		const char *dev_fmt, ...)
> 
> Can we drop the 'single' in the name? Otherwise it's quite a long
> function name. I think name clk_register_clkdev makes it clear already
> that we only register a single clkdev.

clkdev_register?

Dome
