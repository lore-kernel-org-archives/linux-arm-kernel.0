From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 25 Nov 2015 10:51:31 -0500 (EST)
Subject: [PATCH] ARM: mach-orion5x: fix legacy get_irqnr_and_base
In-Reply-To: <20151125154551.GD6520@io.lakedaemon.net>
References: <alpine.LFD.2.20.1511222240150.22569@knanqh.ubzr>
 <20151125144545.GA6520@io.lakedaemon.net>
 <alpine.LFD.2.20.1511250948470.22569@knanqh.ubzr>
 <20151125145552.GB6520@io.lakedaemon.net>
 <alpine.LFD.2.20.1511251027210.22569@knanqh.ubzr>
 <20151125154551.GD6520@io.lakedaemon.net>
Message-ID: <alpine.LFD.2.20.1511251047110.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Nov 2015, Jason Cooper wrote:

> On Wed, Nov 25, 2015 at 10:38:03AM -0500, Nicolas Pitre wrote:
> ...
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
> The only users I know of were Debian.  They had their ARM build servers
> running on some.  They have since been upgraded thanks to kind
> donations.  :-)

I can tell you that those mv78xx0 build servers were also donations. The 
same type of board I retired from my desk.


Nicolas
