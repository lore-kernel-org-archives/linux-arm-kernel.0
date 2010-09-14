From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Sep 2010 13:27:43 -0700
Subject: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100906104413.GD20903@n2100.arm.linux.org.uk>
	<20100914185907.GG8647@atomide.com>
	<20100914190314.GH8647@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
Message-ID: <20100914202743.GK8647@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100914 12:09]:
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > owner at vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Wednesday, September 15, 2010 12:33 AM
> > To: Russell King - ARM Linux
> > Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org;
> > bryan.wu at canonical.com
> > Subject: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
> > 
> > With the recent changes to core ARM kernel code, we can now
> > boot SMP kernel on UP systems. Update omap3_defconfig to
> > enable SMP. This allows us to remove omap_4430sdp_defconfig.
> >
> Not yet.
> We still have some issues around Ethernet, bridge/syslink,
> sensors but hopefully we should be able to fix those.
> Will have a closer look at this and see if these can be
> easily fixed.

Sounds like you're having these problems anyways and they
are not related to the defconfigs?

Considering Linus' earlier comments on the defconfigs, I don't
see any reasonds not to merge this patch. If TI wants to fix up
some other things, there's still about two weeks before -rc6.

> > In addition to enabling SMP, we also need to disable some
> > options to make the system boot:
> > 
> > - For some reason LOCK_STAT causes tons of
> >   WARNING: at mm/percpu-vm.c:320 pcpu_alloc+0x2fc/0x888()
> >   so disable it for now.
> > 
> > - MUSB init fails for multi-omap, disable it for now.
> > 
> > - LOCAL_TIMERS hangs on omap4, disable it for now.
>
> This is expected on omap4 ES1.0 and hence not enabled
> in the omap_4430sdp_defconfig.

Maybe add a check for ES1.0 there to the init then?

Regards,

Tony
