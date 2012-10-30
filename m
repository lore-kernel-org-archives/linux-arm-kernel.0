From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2012 09:20:46 +0100
Subject: [PATCH 1/2] arm: bcm2835: move to the multiplatform support
In-Reply-To: <508F3BFF.6010305@wwwdotorg.org>
References: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <508F3BFF.6010305@wwwdotorg.org>
Message-ID: <20121030092046.7d20407b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

Thanks for taking the time to look at this patch.

On Mon, 29 Oct 2012 20:31:27 -0600, Stephen Warren wrote:

> Since CONFIG_VFP is enabled in bcm2835_defconfig (or in general, could
> be enabled in anyone's .config), I guess that means I can't apply the
> patch yet, because the VFP fix you mention above doesn't seem to have
> been applied anywhere, so applying it would cause bcm2835_defconfig to
> be unbootable. To apply this, I'd need to merge in a branch containing
> the VFP fix first.

I'm pretty sure the VFP fix will land somewhere at some point, we can
wait this moment to merge this multiplatform bcm2835 support patch.

> What branch is this patch series based on? Neither "git am" not "git am
> -3" will apply the series; apparently my repo doesn't have the blobs to
> perform the 3-way merge -3 invokes even though I have a remote for
> linux-next which should pick up most blob sources.

This is my fault, sorry. I based this patch on a branch that contains
the VFP fix + the irqchip changes I've been proposing. I can resend a
new version based on 3.7-rc3, or arm-soc/for-next, at your preference.

> A couple minor comments on the code itself:
> 
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> 
> > +	config DEBUG_BCM2835_UART
> > +		bool "Kernel low-level debugging messages via BCM2835 UART"
> > +		depends on ARCH_BCM2835
> > +		help
> > +		  Say Y here if you want kernel low-level debugging support
> > +		  on BCM2835 based platforms.
> > +
> 
> Since the SoC has multiple UARTs, does it make sense to rename that
> something like DEBUG_BM2835_PL011_UART?

Agreed.

> > diff --git a/arch/arm/mach-bcm2835/include/mach/debug-macro.S b/arch/arm/include/debug/bcm2835.S
> 
> > -#include <mach/bcm2835_soc.h>
> > +#define BCM2835_DEBUG_PHYS	0x20201000
> > +#define BCM2835_DEBUG_VIRT	0xf0201000
> 
> Especially since I have to wait to apply this anyway, I'd prefer to
> avoid that part of this patch, by calling debug_ll_io_init() from
> bcm2835_map_io(). That patch unfortunately also isn't checked in yet,
> but I'll try to chase it down.

Ok, fine with that. I can respin this multiplatform patch once VFP and
debug_ll_io_init() are available.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
