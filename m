From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Sep 2011 21:55:24 +0800
Subject: [PATCH] ARM i.MX gic: add handle_irq function
In-Reply-To: <20110926131036.GI22455@n2100.arm.linux.org.uk>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
	<1316797284-21010-1-git-send-email-shawn.guo@linaro.org>
	<20110926131036.GI22455@n2100.arm.linux.org.uk>
Message-ID: <20110926135523.GC17577@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 02:10:36PM +0100, Russell King - ARM Linux wrote:
> On Sat, Sep 24, 2011 at 01:01:24AM +0800, Shawn Guo wrote:
> > +#ifdef CONFIG_SMP
> > +		else if (irqnr < 16) {
> > +			writel_relaxed(irqstat, gic_cpu_base_addr +
> > +						GIC_CPU_EOI);
> > +			do_IPI(irqnr, regs);
> > +		}
> > +#endif
> > +#ifdef CONFIG_LOCAL_TIMERS
> > +		else if (irqnr == 29) {
> > +			writel_relaxed(irqstat, gic_cpu_base_addr +
> > +						GIC_CPU_EOI);
> > +			do_local_timer(regs);
> 
> Neither of these two functions are designed to be called from C code.
> Notice that they are marked __exception or __exception_irq_entry, and
> thus they expect to have a pt_regs structure directly above themselves.
> 
Thanks for the points.  Since the testing did not tell any problem,
I guess we can use it as a temporary solution before we have a
sophisticated implementation available in GIC common code?

-- 
Regards,
Shawn
