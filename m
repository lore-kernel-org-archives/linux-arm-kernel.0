From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Tue, 29 Jan 2013 17:19:27 +0530
Subject: [PATCH v1 1/5] ARM: cache-l2x0: add 'smc' identifier
In-Reply-To: <20130129113325.GG2637@n2100.arm.linux.org.uk>
References: <20130129101328.GA11878@bnru10>
 <20130129113325.GG2637@n2100.arm.linux.org.uk>
Message-ID: <20130129114926.GA14624@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 12:33:25 +0100, Russell King - ARM Linux wrote:
> On Tue, Jan 29, 2013 at 03:43:31PM +0530, srinidhi kasagar wrote:
> > Add 'smc' (Secure Monitor Call) identifier to differentiates
> > the platforms which implements this.
> 
> This patch makes no sense.
> 
> So, if setting 'smc' in the DT description is supposed to mean that
> the platform has a secure monitor then...
> 
> > +	is_smc = of_property_read_bool(np, "smc");
> > +
> > +	if (is_smc) {
> > +		/* set the debug interface */
> > +		outer_cache.set_debug = pl310_set_debug;
> > +	}
> 
> Now, let's look at what pl310_set_debug() does:
> 
> static void pl310_set_debug(unsigned long val)
> {
>         writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);

You can do this operation (write to DEBUG_CTRL) only if SMC is implemented.

> }
> 
> Can you explain where the secure monitor call is there please, because
> I can't see one.  In fact, this is the function used when there _isn't_
> a secure monitor.  So this patch just seems totally wrong to me.

regards/srinidhi
