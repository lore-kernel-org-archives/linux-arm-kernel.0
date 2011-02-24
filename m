From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Feb 2011 12:21:57 -0800
Subject: [PATCH] OMAP2+: clocksource: fix crash on boot when
	!CONFIG_OMAP_32K_TIMER
In-Reply-To: <alpine.DEB.2.00.1102221958190.22636@utopia.booyaka.com>
References: <alpine.DEB.2.00.1102221958190.22636@utopia.booyaka.com>
Message-ID: <20110224202157.GG20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110222 18:58]:
> 
> OMAP2+ kernels built without CONFIG_OMAP_32K_TIMER crash on boot after the
> 2.6.38 sched_clock changes:
> 
> [    0.000000] OMAP clockevent source: GPTIMER1 at 13000000 Hz
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    0.000000] pgd = c0004000
> [    0.000000] [00000000] *pgd=00000000
> [    0.000000] Internal error: Oops: 80000005 [#1] SMP
> [    0.000000] last sysfs file:
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0    Not tainted  (2.6.38-rc5-00057-g04aa67d #152)
> [    0.000000] PC is at 0x0
> [    0.000000] LR is at sched_clock_poll+0x2c/0x3c
> 
> Without CONFIG_OMAP_32K_TIMER, the kernel has an clockevent and
> clocksource resolution about three orders of magnitude higher than
> with CONFIG_OMAP_32K_TIMER set.  The tradeoff is that the lowest
> power consumption states are not available.
> 
> Fix by calling init_sched_clock() from the GPTIMER clocksource init code.

I'll queue this as a fix as it's a regression.

Tony
