From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 21 Feb 2012 22:21:41 +0100
Subject: [PATCH 0/2] Move some stuff into the new mach-s3c24xx
Message-ID: <201202212221.41744.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches move the s3c2443 common clock code and the dma
base code from plat-s3c24xx to mach-s3c24xx and apply on top of the
current s3c24xx-cleanup topic-branch.

The s3c2443-clock.c got a common-s3c2443.c name, to hold more common
code for s3c2443/2416/2450 later on.

I'm still not sure what would be a fitting name for "s3c2443 and later",
so please speak up everyone with better ideas :-) .

I can also do more later on, but would like to check first if my direction
is correct :-)

Heiko

Heiko Stuebner (2):
  ARM: S3C24XX: Move s3c2443-clock.c to mach-s3c24xx
  ARM: S3C24XX: Move the DMA base code to mach-s3c24xx

 arch/arm/mach-s3c24xx/Kconfig          |   32 +-
 arch/arm/mach-s3c24xx/Makefile         |    5 +
 arch/arm/mach-s3c24xx/common-s3c2443.c |  644 ++++++++++++++
 arch/arm/mach-s3c24xx/dma.c            | 1469 ++++++++++++++++++++++++++++++++
 arch/arm/plat-s3c24xx/Kconfig          |   22 -
 arch/arm/plat-s3c24xx/Makefile         |    2 -
 arch/arm/plat-s3c24xx/dma.c            | 1469 --------------------------------
 arch/arm/plat-s3c24xx/s3c2443-clock.c  |  635 --------------
 8 files changed, 2148 insertions(+), 2130 deletions(-)
 create mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c
 create mode 100644 arch/arm/mach-s3c24xx/dma.c
 delete mode 100644 arch/arm/plat-s3c24xx/dma.c
 delete mode 100644 arch/arm/plat-s3c24xx/s3c2443-clock.c

-- 
1.7.2.3
