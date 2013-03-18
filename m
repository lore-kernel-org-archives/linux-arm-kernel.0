From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 18 Mar 2013 17:27:18 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308172950.GC4094@obsidianresearch.com>
References: <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
 <20130307230516.GA28975@obsidianresearch.com>
 <20130308091052.18612729@skate>
 <20130308172950.GC4094@obsidianresearch.com>
Message-ID: <20130318172718.4f8f45b9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Fri, 8 Mar 2013 10:29:50 -0700, Jason Gunthorpe wrote:

> > Sorry, but we _do_ want the kernel to be able to set those timings
> > parameters, and therefore, a Device Bus driver will be needed,
> > regardless of whether it creates the address window or not.
> 
> See the very good idea from Maxime Bizon about autoprobing the ONFI
> timings directly from the NAND chip.

ONFI (Open NAND Firmware Interface) is about NAND, while the Device Bus
driver submitted by Ezequiel is about NOR. I don't think NORs have a
standard way of exposing their memory timings requirements. And the
Device Bus driver is not only for NORs, but also for example for FPGAs
connected on the memory bus.

Ezequiel followed the work done by Jon Hunter on the GPMC driver for
the memory bus of OMAP SoCs, which includes the definition of timings
in the Device Tree. To me, it seems like defining the timings in the
Device Tree do make sense, and "ONFI" is not a good enough answer to
get rid of the Device Bus driver submitted by Ezequiel.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
