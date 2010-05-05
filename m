From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 May 2010 10:43:35 -0700
Subject: Old DSS code broken as module (was "RE: [PATCH 11/11]
	omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig")
In-Reply-To: <A24693684029E5489D1D202277BE8944552579A3@dlee02.ent.ti.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203411.25812.30019.stgit@baageli.muru.com>
	<A24693684029E5489D1D202277BE8944552579A3@dlee02.ent.ti.com>
Message-ID: <20100505174335.GZ29604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aguirre, Sergio <saaguirre@ti.com> [100505 10:27]:
> Tony,
> 
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > owner at vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Friday, April 30, 2010 3:34 PM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: linux-omap at vger.kernel.org
> > Subject: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in
> > omap3_defconfig
> > 
> > Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> > at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> > omap FB code is fixed.
> > 
> > This allows booting omap3_defconfig on various omaps. Tested on
> > 2420-n8x0, 3430-n900, 3630-zoom3 and 4430-blaze. Note that n8x0
> > still has issues with starting user space because of TLS and
> > VFP.
> 
> (Looping Tomi)
> 
> Unfortunately, your patch is uncovering an issue with old DSS code to
> compile it as module, which I think is caused by this:
> 
> A single omapfb.ko is attempted to be created in drivers/video/omap/ folder,
> but the included source files (DSS code + lcd drivers), results in multiple
> module_init entries added in a single module, and therefore giving errors of
> duplicate init_module entries between omapfb_main.c and the lcd_*.c files.
> 
> So, either you disable old DSS driver completely, or you have it as
> built-in.

OK thanks for pointing that out. I'll disable it so we have a
booting omap3_defconfig (with the modules compiling).

Regards,

Tony
