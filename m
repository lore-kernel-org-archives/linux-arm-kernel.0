From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Dec 2011 08:17:23 +0000
Subject: [PATCH 3/4] ARM: smp_twd: get the rate from a clock
In-Reply-To: <4EE6E17E.5040902@ti.com>
References: <1323683847-23902-1-git-send-email-linus.walleij@stericsson.com>
 <4EE6E17E.5040902@ti.com>
Message-ID: <20111213081723.GB14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 10:54:14AM +0530, Santosh Shilimkar wrote:
> > +static struct clk *twd_get_clock(void)
> > +{
> > +	struct clk *clk;
> > +	int err;
> > +
> > +	clk = clk_get_sys("smp_twd", NULL);
> 
> As noticed by Mike, would be better to use con_id instead
> of dev_id here. I mean,
> clk = clk_get_sys(NULL, "smp_twd");

Why?  It makes more sense for a device ID to be passed for this.
