From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 25 Nov 2015 14:55:52 +0000
Subject: [PATCH] ARM: mach-orion5x: fix legacy get_irqnr_and_base
In-Reply-To: <alpine.LFD.2.20.1511250948470.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511222240150.22569@knanqh.ubzr>
 <20151125144545.GA6520@io.lakedaemon.net>
 <alpine.LFD.2.20.1511250948470.22569@knanqh.ubzr>
Message-ID: <20151125145552.GB6520@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 09:54:05AM -0500, Nicolas Pitre wrote:
> On Wed, 25 Nov 2015, Jason Cooper wrote:
> 
> > On Sun, Nov 22, 2015 at 10:44:19PM -0500, Nicolas Pitre wrote:
> > > Commit 5be9fc23cd ("ARM: orion5x: fix legacy orion5x IRQ numbers") shifted
> > > IRQ numbers by one but didn't update the get_irqnr_and_base macro
> > > accordingly.  This macro is involved when CONFIG_MULTI_IRQ_HANDLER
> > > is not defined.
> > > 
> > > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > 
> > Applied to mvebu/fixes with minor tweak to the subject line and Cc's to
> > stable back to v4.2.
> 
> Note that the patch this provides a fix for was introduced in v4.2, but 
> it itself was marked for stable. So if commit 5be9fc23cd was backported 
> back to v3.18 then this patch should also be backported to the same 
> stable versions.
> 
> Same thing for the Dove variant.

Crap.  Nice catch.  I'll update *before* pushing.  :)

thx,

Jason.
