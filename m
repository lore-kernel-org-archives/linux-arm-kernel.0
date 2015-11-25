From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Nov 2015 16:43:13 +0100
Subject: [PATCH] ARM: mach-orion5x: fix legacy get_irqnr_and_base
In-Reply-To: <alpine.LFD.2.20.1511251027210.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511222240150.22569@knanqh.ubzr>
 <20151125144545.GA6520@io.lakedaemon.net>
 <alpine.LFD.2.20.1511250948470.22569@knanqh.ubzr>
 <20151125145552.GB6520@io.lakedaemon.net>
 <alpine.LFD.2.20.1511251027210.22569@knanqh.ubzr>
Message-ID: <20151125154313.GL11384@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> BTW, mv78xx0 is still broken wrt this IRQ #0 usage.  Is it possible that 
> no one uses it?  It is a weird not-completely-SMP architecture that 
> lacks cache coherency support between CPU cores. To fully use both 
> cores, we'd need to have two independent Linux instances with memory 
> partitioning and this was never implemented. I'm unaware of any product 
> using Linux on that SOC either.  My own mv78xx0 dev board took the way 
> of the recycling facility a while ago given the lack of interest.
> 
> Should we "fix" it by removing it outright?

I think it was at the Edinburgh kernel summit/ELCE i met somebody
still using it. If i remember correctly, Linux on one core, and
something else on the other. That was two years ago. I've not heard
anything since.

	 Andrew
