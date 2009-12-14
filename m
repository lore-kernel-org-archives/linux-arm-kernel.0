From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 14 Dec 2009 16:10:05 +0000
Subject: [PATCH 2/5] arm/oprofile: reserve the PMU when starting
In-Reply-To: <000f01ca7cd7$1c073e10$5415ba30$@deacon@arm.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
	<000f01ca7cd7$1c073e10$5415ba30$@deacon@arm.com>
Message-ID: <20091214161005.GH4141@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2009 at 04:04:25PM -0000, Will Deacon wrote:
> > -static int irqs[] = {
> > -#ifdef CONFIG_ARCH_OMAP2
> > -	3,
> > -#endif
> > -#ifdef CONFIG_ARCH_BCMRING
> > -	IRQ_PMUIRQ, /* for BCMRING, ARM PMU interrupt is 43 */
> > -#endif
> > -#ifdef CONFIG_ARCH_PC3XX
> > -        IRQ_NPMUIRQ,
> > -#endif
> <snip>
> 
> These last three lines don't apply cleanly.
> I think you've based this patch on top of your previous one.
Apologies, this is is from a platform (pc3xx) that isn't in mainline. I've
been using this platform to test the perf events code. I'll submit the next
lot directly off of tip/master.

Jamie
