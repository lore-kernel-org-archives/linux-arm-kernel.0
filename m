From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 26 Mar 2011 21:24:50 +0100 (CET)
Subject: [patch 02/23] arm: tegra: Remove unused function which fiddles
	with irq_desc
In-Reply-To: <4D8E4897.5030705@nvidia.com>
References: <20110325131617.258789658@linutronix.de>
	<20110325132047.552074703@linutronix.de>
	<4D8E4897.5030705@nvidia.com>
Message-ID: <alpine.LFD.2.00.1103262118010.31464@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 27 Mar 2011, Varun Wadekar wrote:
> 
> Thomas, then how do you think we should handle restoring of gpio states
> across suspend-resume cycles?

That code is unused. Period. No caller, nothing nada. So what does it
handle?
 
> > -
> > -	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
> > -		struct irq_desc *desc = irq_to_desc(i);
> > -		if (!desc || (desc->status & IRQ_WAKEUP))
> > -			continue;
> > -		enable_irq(i);
> > -	}

And this part is totally unacceptable and should have never been
merged. Further it is in the way of cleanups to the core code and as
there is no user I'm not willing to even think about what it does and
why it is there.

FYI, the core code deals with interrupt suspending/resuming
already. So if there is a problem with that which does not cover your
specific problem, then you better talk to me before hacking up such
private workarounds and expecting that I tolerate them in unused code.

Thanks,

	tglx
