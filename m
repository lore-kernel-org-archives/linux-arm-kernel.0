From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:10 +0530
Subject: [PATCH 00/33] Use common macro to define resources
Message-ID: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some helper macros (DEFINE_RES_XXX) for defining resource
structures. This patchset migrates all the earlier resource
definitions (within Samsung specific code base) to use these macros.

In some cases, it was not possible to use DEFINE_RES_IRQ() macro because
of usage of additional flags. In those cases, DEFINE_RES_NAMED() macro
is used instead.

The patches are rebased on top of Kukjin's for-next branch at this commit.

d0ee53a Merge branch 'next/board-samsung' into for-next

Tushar Behera (33):
  ARM: SAMSUNG: devs: Use common macro to define resources
  ARM: EXYNOS: dev-ahci: Use common macro to define resources
  ARM: EXYNOS: dev-audio: Use common macro to define resources
  ARM: EXYNOS: mach-armlex4210: Use common macro to define resources
  ARM: EXYNOS: mach-smdkv310: Use common macro to define resources
  ARM: S3C24XX: dev-uart: Use common macro to define resources
  ARM: S3C24XX: bast-ide: Use common macro to define resources
  ARM: S3C24XX: mach-amlm5900: Use common macro to define resources
  ARM: S3C24XX: mach-anubis: Use common macro to define resources
  ARM: S3C24XX: mach-at2440evb: Use common macro to define resources
  ARM: S3C24XX: mach-bast: Use common macro to define resources
  ARM: S3C24XX: mach-gta02: Use common macro to define resources
  ARM: S3C24XX: mach-h1940: Use common macro to define resources
  ARM: S3C24XX: mach-mini2440: Use common macro to define resources
  ARM: S3C24XX: mach-nexcoder: Use common macro to define resources
  ARM: S3C24XX: mach-osiris: Use common macro to define resources
  ARM: S3C24XX: mach-otom: Use common macro to define resources
  ARM: S3C24XX: mach-qt2410: Use common macro to define resources
  ARM: S3C24XX: mach-rx1950: Use common macro to define resources
  ARM: S3C24XX: mach-tct_hammer: Use common macro to define resources
  ARM: S3C24XX: mach-vr1000: Use common macro to define resources
  ARM: S3C24XX: simtec-nor: Use common macro to define resources
  ARM: S3C64XX: dev-audio: Use common macro to define resources
  ARM: S3C64XX: dev-uart: Use common macro to define resources
  ARM: S3C64XX: mach-anw6410: Use common macro to define resources
  ARM: S3C64XX: mach-crag6410: Use common macro to define resources
  ARM: S3C64XX: mach-mini6410: Use common macro to define resources
  ARM: S3C64XX: mach-real6410: Use common macro to define resources
  ARM: S3C64XX: mach-smdk6410: Use common macro to define resources
  ARM: S5P64X0: dev-audio: Use common macro to define resources
  ARM: S5PC100: dev-audio: Use common macro to define resources
  ARM: S5PV210: dev-audio: Use common macro to define resources
  ARM: S5PV210: mach-smdkv210: Use common macro to define resources

 arch/arm/mach-exynos/dev-ahci.c         |   12 +--
 arch/arm/mach-exynos/dev-audio.c        |  156 +++++-------------------------
 arch/arm/mach-exynos/mach-armlex4210.c  |   13 +--
 arch/arm/mach-exynos/mach-smdkv310.c    |   13 +--
 arch/arm/mach-s3c24xx/bast-ide.c        |   36 +------
 arch/arm/mach-s3c24xx/mach-amlm5900.c   |    9 +--
 arch/arm/mach-s3c24xx/mach-anubis.c     |   62 ++----------
 arch/arm/mach-s3c24xx/mach-at2440evb.c  |   19 +---
 arch/arm/mach-s3c24xx/mach-bast.c       |   45 ++-------
 arch/arm/mach-s3c24xx/mach-gta02.c      |    7 +-
 arch/arm/mach-s3c24xx/mach-h1940.c      |    9 +--
 arch/arm/mach-s3c24xx/mach-mini2440.c   |   19 +---
 arch/arm/mach-s3c24xx/mach-nexcoder.c   |    6 +-
 arch/arm/mach-s3c24xx/mach-osiris.c     |   12 +--
 arch/arm/mach-s3c24xx/mach-otom.c       |    6 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c     |   12 +--
 arch/arm/mach-s3c24xx/mach-rx1950.c     |    9 +--
 arch/arm/mach-s3c24xx/mach-tct_hammer.c |    7 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c     |   39 ++------
 arch/arm/mach-s3c24xx/simtec-nor.c      |    6 +-
 arch/arm/mach-s3c64xx/dev-audio.c       |  120 ++++--------------------
 arch/arm/mach-s3c64xx/dev-uart.c        |   48 ++--------
 arch/arm/mach-s3c64xx/mach-anw6410.c    |   19 +---
 arch/arm/mach-s3c64xx/mach-crag6410.c   |   26 +----
 arch/arm/mach-s3c64xx/mach-mini6410.c   |   19 +---
 arch/arm/mach-s3c64xx/mach-real6410.c   |   19 +---
 arch/arm/mach-s3c64xx/mach-smdk6410.c   |   13 +--
 arch/arm/mach-s5p64x0/dev-audio.c       |   72 +++------------
 arch/arm/mach-s5pc100/dev-audio.c       |  138 +++++-----------------------
 arch/arm/mach-s5pv210/dev-audio.c       |  156 +++++-------------------------
 arch/arm/mach-s5pv210/mach-smdkv210.c   |   19 +---
 arch/arm/plat-s3c24xx/dev-uart.c        |   56 +++--------
 arch/arm/plat-samsung/devs.c            |   12 +--
 33 files changed, 224 insertions(+), 990 deletions(-)

-- 
1.7.4.1
