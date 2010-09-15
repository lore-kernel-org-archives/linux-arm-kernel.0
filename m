From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 15 Sep 2010 11:41:08 +0530
Subject: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
In-Reply-To: <20100914202743.GK8647@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100906104413.GD20903@n2100.arm.linux.org.uk>
	<20100914185907.GG8647@atomide.com> <20100914190314.GH8647@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
	<20100914202743.GK8647@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F9E1@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Wednesday, September 15, 2010 1:58 AM
> To: Shilimkar, Santosh
> Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org; linux-
> omap at vger.kernel.org; bryan.wu at canonical.com
> Subject: Re: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100914 12:09]:
> > > -----Original Message-----
> > > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > > owner at vger.kernel.org] On Behalf Of Tony Lindgren
> > > Sent: Wednesday, September 15, 2010 12:33 AM
> > > To: Russell King - ARM Linux
> > > Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org;
> > > bryan.wu at canonical.com
> > > Subject: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
> > >
> > > With the recent changes to core ARM kernel code, we can now
> > > boot SMP kernel on UP systems. Update omap3_defconfig to
> > > enable SMP. This allows us to remove omap_4430sdp_defconfig.
> > >
> > Not yet.
> > We still have some issues around Ethernet, bridge/syslink,
> > sensors but hopefully we should be able to fix those.
> > Will have a closer look at this and see if these can be
> > easily fixed.
> 
> Sounds like you're having these problems anyways and they
> are not related to the defconfigs?
> 
Well the issues are because of defconfig but mostly fixable.
Will hold on my comments till I test the new defconfig on OMAP4.

> Considering Linus' earlier comments on the defconfigs, I don't
> see any reasonds not to merge this patch. If TI wants to fix up
> some other things, there's still about two weeks before -rc6.
>
Sure. I am just saying let's attempt to fix the remaining issues
and if it doesn't happen in next week, anyway this patch will
get merged.
 
> > > In addition to enabling SMP, we also need to disable some
> > > options to make the system boot:
> > >
> > > - For some reason LOCK_STAT causes tons of
> > >   WARNING: at mm/percpu-vm.c:320 pcpu_alloc+0x2fc/0x888()
> > >   so disable it for now.
> > >
> > > - MUSB init fails for multi-omap, disable it for now.
> > >
> > > - LOCAL_TIMERS hangs on omap4, disable it for now.
> >
> > This is expected on omap4 ES1.0 and hence not enabled
> > in the omap_4430sdp_defconfig.
> 
> Maybe add a check for ES1.0 there to the init then?
> 
Yes but its ARM generic code and I don't want to pollute it
with omap checks.. Will see if some other trick can fix this.

Regards,
Santosh
