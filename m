From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Apr 2012 12:48:03 +0100
Subject: [PATCH 02/17] ARM clps711x: Added Cirrus Logic EP7312 CPU variant
In-Reply-To: <201204211121.49610.arnd@arndb.de>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <1334999490-27177-3-git-send-email-shc_work@mail.ru>
 <201204211121.49610.arnd@arndb.de>
Message-ID: <20120421114803.GE24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 11:21:49AM +0000, Arnd Bergmann wrote:
> On Saturday 21 April 2012, Alexander Shiyan wrote:
> > 
> > Added register definitions specific to EP7312 and the necessary
> > configuration options.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/include/asm/hardware/ep7312.h         |  106 ++++++++++++++++++++++++
> >  arch/arm/mach-clps711x/Kconfig                 |    9 ++-
> >  arch/arm/mach-clps711x/include/mach/hardware.h |    4 +
> >  drivers/net/irda/Kconfig                       |    3 +-
> >  4 files changed, 119 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm/include/asm/hardware/ep7312.h
> 
> I'm missing some historical background here. Why are these files in asm/hardware
> rather than in mach/? Should we move them to the platform directory?

That's where we used to put truely hardware dependent stuff, rather than
machine type stuff when the structure was first implemented.  At that time
we had a number of different mach-* directories wanting to share things
like the acorn IOC/IOMD stuff, and there's also sharing of definitions
between CLPS711x and EP93xx.

That was long before we invented the plat-* stuff - but even that doesn't
actually cover what asm/hardware does - eg, the SA1111 stuff shared
between SA11x0 and PXA.
