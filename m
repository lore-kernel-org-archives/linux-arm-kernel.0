From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 6 Mar 2012 10:57:15 +0100
Subject: [PATCH 0/4] S3C24XX: Another move of code to the new mach directory
Message-ID: <201203061057.15815.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the easy moves of common code for the SMDKs,
Simtec boards and device setup from plat-s3c24xx to mach-s3c24xx.

It also contains an extra patch to keep the Simtec code more together.

Changes to the Kconfig and Makefile will probably conflict with the
S3C2416-SPI series posted sunday, but this is ok, as the SPI series
will probably have to wait for 3.5 anyway and can be redone then.

Heiko Stuebner (4):
  ARM: S3C24XX: Move common-smdk code to mach directory
  ARM: S3C24XX: move simtec-specific code to mach directory
  ARM: S3C24XX: Consolidate Simtec extensions
  ARM: S3C24XX: Move device setup files to mach directory

 arch/arm/mach-s3c24xx/Kconfig                      |   62 +++++++++++++++-----
 arch/arm/mach-s3c24xx/Makefile                     |   12 +++-
 .../{plat-s3c24xx => mach-s3c24xx}/common-smdk.c   |    0
 arch/arm/mach-s3c24xx/mach-anubis.c                |    1 +
 arch/arm/mach-s3c24xx/mach-bast.c                  |    3 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                |    3 +-
 .../arm/{plat-s3c24xx => mach-s3c24xx}/setup-i2c.c |    0
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-ts.c |    0
 .../{plat-s3c24xx => mach-s3c24xx}/simtec-audio.c  |    2 +
 .../mach-s3c24xx/{nor-simtec.c => simtec-nor.c}    |    2 +-
 .../pm-simtec.c => mach-s3c24xx/simtec-pm.c}       |    0
 .../mach-s3c24xx/{usb-simtec.c => simtec-usb.c}    |    2 +-
 arch/arm/mach-s3c24xx/{nor-simtec.h => simtec.h}   |    9 +++-
 arch/arm/mach-s3c24xx/usb-simtec.h                 |   16 -----
 arch/arm/plat-s3c24xx/Kconfig                      |   23 -------
 arch/arm/plat-s3c24xx/Makefile                     |   10 ---
 arch/arm/plat-samsung/include/plat/audio-simtec.h  |    3 -
 17 files changed, 72 insertions(+), 76 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/common-smdk.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-i2c.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-ts.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/simtec-audio.c (98%)
 rename arch/arm/mach-s3c24xx/{nor-simtec.c => simtec-nor.c} (98%)
 rename arch/arm/{plat-s3c24xx/pm-simtec.c => mach-s3c24xx/simtec-pm.c} (100%)
 rename arch/arm/mach-s3c24xx/{usb-simtec.c => simtec-usb.c} (99%)
 rename arch/arm/mach-s3c24xx/{nor-simtec.h => simtec.h} (63%)
 delete mode 100644 arch/arm/mach-s3c24xx/usb-simtec.h

-- 
1.7.5.4
