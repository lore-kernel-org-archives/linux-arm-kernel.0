From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Jul 2014 18:15:23 +0200
Subject: [PATCH 2/3] ARM: remove remaining definitions of
 PLAT_PHYS_OFFSET from <mach/memory.h>
In-Reply-To: <20140702103819.GH32514@n2100.arm.linux.org.uk>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1404295043-6661-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140702103819.GH32514@n2100.arm.linux.org.uk>
Message-ID: <20140702161523.GR14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:38:19AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 02, 2014 at 11:57:22AM +0200, Uwe Kleine-K?nig wrote:
> >  config PHYS_OFFSET
> >  	hex "Physical address of main memory" if MMU
> > -	depends on !ARM_PATCH_PHYS_VIRT && !NEED_MACH_MEMORY_H
> > +	depends on !ARM_PATCH_PHYS_VIRT
> >  	default DRAM_BASE if !MMU
> > +	default 0x00000000 if ARCH_EBSA110 || EP93XX_SDCE3_SYNC_PHYS_OFFSET || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_IOP13XX || ARCH_KS8695 || (ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET)
> 
> It would be nice to see a few \ characters in that long line.
Yeah, right.

Also note that there is an ARCH_FOOTBRIDGE while mach-footbridge is
selected by FOOTBRIDGE. Following up your comments to the footbridge
series one of them should be changed. (But I wonder which one.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
