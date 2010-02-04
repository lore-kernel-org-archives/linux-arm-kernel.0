From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Feb 2010 10:51:47 +0100
Subject: change boot requirements [Was: make PHYS_OFFSET determined at
	run time (unfinished)]
In-Reply-To: <20100130210231.GC16345@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
	<20100122115831.GA8377@pengutronix.de>
	<20100125173201.GA14834@pengutronix.de>
	<4B5DF1C9.6090102@bluewatersys.com>
	<20100130210231.GC16345@pengutronix.de>
Message-ID: <20100204095147.GA6562@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

> The following changes since commit 499a2673713c85734a54c37dd90b4b729de399c4:
>   Linus Torvalds (1):
>         Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/ukl/linux-2.6.git arm/booting

Can you please pull this branch for the .34 merge window?  Since the
last post one new patch was added to that branch.  I'll send it in reply
to this mail.

Current shortlog and diffstat are below.

Thanks
Uwe

The following changes since commit 499a2673713c85734a54c37dd90b4b729de399c4:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git arm/booting

Uwe Kleine-K?nig (10):
      zImage: fix comments for cache_on, cache_off and cache_clean_flush
      zImage: some comments for __armv3_mpu_cache_on
      zImage: __armv3_mpu_cache_flush: respect should-be-zero specification
      zImage: annotate debug functions about corrupted registers
      zImage: don't define unused symbol initrd_phys
      arm: deprecate support for old way to pass kernel parameters
      zImage: don't hard code the stack size twice
      uImage: require passing a LOADADDR when building with RUNTIME_PHYSOFFSET
      Allow PHYS_OFFSET to be runtime determined
      arm: remove bit-rotten STANDALONE_DEBUG for decompressor

 Documentation/arm/Booting               |    1 +
 arch/arm/Kconfig                        |    9 ++++
 arch/arm/boot/Makefile                  |    6 ++-
 arch/arm/boot/compressed/Makefile       |   10 ++---
 arch/arm/boot/compressed/Makefile.debug |   23 ---------
 arch/arm/boot/compressed/head.S         |   76 +++++++++++++++++++++++++++---
 arch/arm/boot/compressed/misc.c         |   27 -----------
 arch/arm/include/asm/memory.h           |    5 ++
 arch/arm/kernel/Makefile                |    4 +-
 arch/arm/kernel/compat.c                |    7 ---
 arch/arm/kernel/compat.h                |    2 -
 arch/arm/kernel/head.S                  |   31 +++++++++---
 arch/arm/kernel/setup.c                 |   21 ++++++++-
 13 files changed, 138 insertions(+), 84 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/Makefile.debug

Best regards
Uwe
-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
