From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 25 Nov 2015 10:38:03 -0500 (EST)
Subject: [PATCH] ARM: mach-orion5x: fix legacy get_irqnr_and_base
In-Reply-To: <20151125145552.GB6520@io.lakedaemon.net>
References: <alpine.LFD.2.20.1511222240150.22569@knanqh.ubzr>
 <20151125144545.GA6520@io.lakedaemon.net>
 <alpine.LFD.2.20.1511250948470.22569@knanqh.ubzr>
 <20151125145552.GB6520@io.lakedaemon.net>
Message-ID: <alpine.LFD.2.20.1511251027210.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Nov 2015, Jason Cooper wrote:

> On Wed, Nov 25, 2015 at 09:54:05AM -0500, Nicolas Pitre wrote:
> > On Wed, 25 Nov 2015, Jason Cooper wrote:
> > 
> > > On Sun, Nov 22, 2015 at 10:44:19PM -0500, Nicolas Pitre wrote:
> > > > Commit 5be9fc23cd ("ARM: orion5x: fix legacy orion5x IRQ numbers") shifted
> > > > IRQ numbers by one but didn't update the get_irqnr_and_base macro
> > > > accordingly.  This macro is involved when CONFIG_MULTI_IRQ_HANDLER
> > > > is not defined.
> > > > 
> > > > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > > 
> > > Applied to mvebu/fixes with minor tweak to the subject line and Cc's to
> > > stable back to v4.2.
> > 
> > Note that the patch this provides a fix for was introduced in v4.2, but 
> > it itself was marked for stable. So if commit 5be9fc23cd was backported 
> > back to v3.18 then this patch should also be backported to the same 
> > stable versions.
> > 
> > Same thing for the Dove variant.
> 
> Crap.  Nice catch.  I'll update *before* pushing.  :)

BTW, mv78xx0 is still broken wrt this IRQ #0 usage.  Is it possible that 
no one uses it?  It is a weird not-completely-SMP architecture that 
lacks cache coherency support between CPU cores. To fully use both 
cores, we'd need to have two independent Linux instances with memory 
partitioning and this was never implemented. I'm unaware of any product 
using Linux on that SOC either.  My own mv78xx0 dev board took the way 
of the recycling facility a while ago given the lack of interest.

Should we "fix" it by removing it outright?


Nicolas
