From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Feb 2010 11:15:38 +0100
Subject: pull request for .34
Message-ID: <20100218101538.GA8659@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

I collected the raw_spinlock conversion patches by Thomas[1] and put them
together with my patches in my repository.

All the patches have been posted on this list without anyone having
objections.

I have a patch stack that makes imx21 and imx27 use runtime physoffset,
but I'm not sure yet if I can complete bringing it into shape for the
merge window.

Best regards
Uwe

[1] I only fixed one subject not to contain a patch name

The following changes since commit b0483e78e5c4c9871fc5541875b3bc006846d46b:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../gregkh/tty-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git for-rmk

Thomas Gleixner (12):
      arm: Convert dma_spin_lock to raw_spinlock
      arm: Convert stop_lock to raw_spinlock
      arm: convert die_lock and undef_lock to raw_spinlocks
      arm: Convert l2x0_lock to raw_spinlock
      arm: Convert cpu_asid_lock to raw_spinlock
      arm: Convert xscale minicache_lock to raw_spinlock
      arm: Convert v4 minicache_lock to raw_spinlock
      arm: Convert v6_lock to raw_spinlock
      arm: Convert footbridge gpio and led locks to raw_spinlock
      arm: Convert integrator cm_lock and v3_lock to raw_spinlock
      arm: Convert ixp4xx pci_lock to raw_spinlock
      arm: Convert shark leds_lock to raw_spinlock

Uwe Kleine-K?nig (13):
      arm/zImage: fix comments for cache_on, cache_off and cache_clean_flush
      arm/zImage: some comments for __armv3_mpu_cache_on
      arm/zImage: __armv3_mpu_cache_flush: respect should-be-zero specification
      arm/zImage: annotate debug functions about corrupted registers
      arm/zImage: don't define unused symbol initrd_phys
      arm: deprecate support for old way to pass kernel parameters
      arm/zImage: don't hard code the stack size twice
      arm/uImage: require passing a LOADADDR when building with RUNTIME_PHYSOFFSET
      arm: Allow PHYS_OFFSET to be runtime determined
      arm: remove bit-rotten STANDALONE_DEBUG for decompressor
      arm/ixp2000: fix type of ixp2000_timer_interrupt
      Merge branch 'arm/booting' into for-rmk
      Merge branch 'arm/raw_spinlock' into for-rmk

 Documentation/arm/Booting                        |    1 +
 arch/arm/Kconfig                                 |    9 +++
 arch/arm/boot/Makefile                           |    6 ++-
 arch/arm/boot/compressed/Makefile                |   10 +--
 arch/arm/boot/compressed/Makefile.debug          |   23 -------
 arch/arm/boot/compressed/head.S                  |   76 +++++++++++++++++++--
 arch/arm/boot/compressed/misc.c                  |   27 --------
 arch/arm/include/asm/dma.h                       |    6 +-
 arch/arm/include/asm/memory.h                    |    5 ++
 arch/arm/kernel/Makefile                         |    4 +-
 arch/arm/kernel/compat.c                         |    7 --
 arch/arm/kernel/compat.h                         |    2 -
 arch/arm/kernel/dma.c                            |    2 +-
 arch/arm/kernel/head.S                           |   31 +++++++--
 arch/arm/kernel/setup.c                          |   21 ++++++-
 arch/arm/kernel/smp.c                            |    6 +-
 arch/arm/kernel/traps.c                          |   20 +++---
 arch/arm/mach-footbridge/include/mach/hardware.h |    2 +-
 arch/arm/mach-footbridge/netwinder-hw.c          |   14 ++--
 arch/arm/mach-footbridge/netwinder-leds.c        |   10 ++--
 arch/arm/mach-integrator/core.c                  |    6 +-
 arch/arm/mach-integrator/pci_v3.c                |   14 ++--
 arch/arm/mach-ixp2000/core.c                     |    2 +-
 arch/arm/mach-ixp4xx/common-pci.c                |   22 +++---
 arch/arm/mach-shark/leds.c                       |    6 +-
 arch/arm/mm/cache-l2x0.c                         |   30 ++++----
 arch/arm/mm/context.c                            |    6 +-
 arch/arm/mm/copypage-v4mc.c                      |    6 +-
 arch/arm/mm/copypage-v6.c                        |   10 ++--
 arch/arm/mm/copypage-xscale.c                    |    6 +-
 drivers/char/ds1620.c                            |    8 +-
 drivers/char/nwflash.c                           |    4 +-
 drivers/mtd/maps/dc21285.c                       |    4 +-
 sound/oss/waveartist.c                           |    4 +-
 34 files changed, 232 insertions(+), 178 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/Makefile.debug
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
