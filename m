From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Feb 2011 15:45:20 -0800
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110124201731.GC13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110123174814.GI30094@n2100.arm.linux.org.uk>
	<20110124201731.GC13589@atomide.com>
Message-ID: <20110214234520.GT20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110124 12:16]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110123 09:47]:
> > On Sun, Jan 23, 2011 at 05:13:44PM +0000, Russell King - ARM Linux wrote:
> > > Move non-mapping and non-irq initialization code out of .map_io and
> > > .init_irq respectively into the new init_early hook.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > ---
> > > I think I've updated this patch correctly for the new platforms merged
> > > into mainline.
> > 
> > Grr, this breaks on OMAP because some of this stuff wants to do ioremap()
> > and therefore wants the kmem allocators initialized.  That's rather
> > annoying...
> 
> So far tested on zoom3 only, but the following gets it booting
> on top of your patch.
> 
> Want to take this one into your series?  

Russell, I'll queue your patch for the upcoming merge window into
devel-early-init branch along with my changes.

Will also post one more clean-up patch.

Regards,

Tony
