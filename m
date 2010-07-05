From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 5 Jul 2010 16:13:44 +0200
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
Message-ID: <20100705141344.GA25407@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series is a merge between Eric's and my patches that we did to
clean up the early boot code.  It doesn't contain runtime physoffset
support for now, but I plan to pick that up later.

Best regards
Uwe

The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git arm/booting

Eric Miao (2):
      ARM: Remove unused PARAMS_PHYS from arch/arm/boot/compressed
      Auto calculate ZRELADDR and provide option for exceptions

Uwe Kleine-K?nig (9):
      ARM: zImage: don't hard code the stack size twice
      ARM: zImage: some comments for __armv3_mpu_cache_on
      ARM: zImage: __armv3_mpu_cache_flush: respect should-be-zero specification
      ARM: zImage: fix comments for cache_on, cache_off and cache_clean_flush
      ARM: zImage: annotate debug functions about corrupted registers
      ARM: remove bit-rotten STANDALONE_DEBUG for decompressor
      ARM: zImage: don't define unused symbol initrd_phys
      ARM: deprecate support for old way to pass kernel parameters
      ARM: uImage: require passing a LOADADDR when building with RUNTIME_PHYSOFFSET

 arch/arm/Kconfig                        |  105 +++++++++++++++++++++++++++++++
 arch/arm/boot/Makefile                  |   14 +++--
 arch/arm/boot/compressed/Makefile       |   11 +---
 arch/arm/boot/compressed/Makefile.debug |   23 -------
 arch/arm/boot/compressed/head.S         |   40 +++++++++---
 arch/arm/boot/compressed/misc.c         |   20 ------
 arch/arm/kernel/Makefile                |    4 +-
 arch/arm/kernel/compat.c                |    7 --
 arch/arm/kernel/compat.h                |    2 -
 arch/arm/kernel/setup.c                 |   11 +++
 10 files changed, 157 insertions(+), 80 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/Makefile.debug
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
