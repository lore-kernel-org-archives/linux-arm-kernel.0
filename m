From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 06 Oct 2011 11:38:04 +0300
Subject: [PATCH 3/4] ARM: OMAP: Remove calls to SRAM allocations for
	framebuffer
In-Reply-To: <20111005224141.GF6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<20111005004544.26980.35612.stgit@kaulin.local>
	<1317797128.2631.2.camel@deskari> <20111005224141.GF6324@atomide.com>
Message-ID: <1317890284.1945.38.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-10-05 at 15:41 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [111004 23:11]:
> > On Tue, 2011-10-04 at 17:45 -0700, Tony Lindgren wrote:
> > > This assumes fixed mappings which will not work once we move
> > > to use ioremap_exec(). It seems that these are currently
> > > not in use, or in use for some out of tree corner cases.
> > > 
> > > If SRAM support for framebuffer is wanted, it should be done
> > > with ioremap in the driver.
> > > 
> > > Note that further removal of the code can now be done,
> > > but that can be done seprately by the driver maintainers.
> > > 
> > > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Looks good to me. I have similar changes in my working branch for omapfb
> > cleanup.
> > 
> > Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Thanks. FYI, looks like there's a warning in display.c:
> 
> arch/arm/mach-omap2/display.c: In function 'omap_display_init':
> arch/arm/mach-omap2/display.c:93: warning: assignment from incompatible pointer type
> 
> Do you have a patch for that already?

Paul should have a patch for that in queue ("OMAP: change
get_context_loss_count ret value to int"). DSS is already using the new
style function pointer, which uses int for return value (versus the
current function which returns u32).

 Tomi
