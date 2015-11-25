From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 25 Nov 2015 10:58:03 -0500 (EST)
Subject: [PATCH] ARM: mach-orion5x: fix legacy get_irqnr_and_base
In-Reply-To: <20151125154313.GL11384@lunn.ch>
References: <alpine.LFD.2.20.1511222240150.22569@knanqh.ubzr>
 <20151125144545.GA6520@io.lakedaemon.net>
 <alpine.LFD.2.20.1511250948470.22569@knanqh.ubzr>
 <20151125145552.GB6520@io.lakedaemon.net>
 <alpine.LFD.2.20.1511251027210.22569@knanqh.ubzr>
 <20151125154313.GL11384@lunn.ch>
Message-ID: <alpine.LFD.2.20.1511251051490.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Nov 2015, Andrew Lunn wrote:

> > BTW, mv78xx0 is still broken wrt this IRQ #0 usage.  Is it possible that 
> > no one uses it?  It is a weird not-completely-SMP architecture that 
> > lacks cache coherency support between CPU cores. To fully use both 
> > cores, we'd need to have two independent Linux instances with memory 
> > partitioning and this was never implemented. I'm unaware of any product 
> > using Linux on that SOC either.  My own mv78xx0 dev board took the way 
> > of the recycling facility a while ago given the lack of interest.
> > 
> > Should we "fix" it by removing it outright?
> 
> I think it was at the Edinburgh kernel summit/ELCE i met somebody
> still using it. If i remember correctly, Linux on one core, and
> something else on the other. That was two years ago. I've not heard
> anything since.

Any chance that somebody would still be interested in running latest 
mainline on it?

The alternative is to remove it and see if someone complains. Bringing 
it back would be just one git revert away.


Nicolas
