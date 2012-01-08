From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 8 Jan 2012 22:22:11 +0100
Subject: [PATCH 0/2] S3C24XX: remove some spi left overs
Message-ID: <201201082222.11305.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series removes unused setup-code of the s3c24xx spi driver.

It has no current in kernel users and also no development activity trying
to change this. I also checked the upstream git of the only board including
the spi.h file (the gta02 at http://git.openmoko.org). The setup calls
are also not used there.

I recall a thread some time back talking about removing the spi-s3c24xx
driver altogether, but as current linux-next still carries the driver
I'm not sure what became of it. So this series does the next smaller thing.


Heiko Stuebner (2):
  S3C24XX: remove unused spi gpio setup functions
  S3C24XX: move spi-s3c24xx platdata out of mach

 arch/arm/mach-s3c2410/include/mach/spi.h     |   38 --------------------------
 arch/arm/mach-s3c2440/mach-gta02.c           |    2 +-
 arch/arm/plat-s3c24xx/Kconfig                |   20 -------------
 arch/arm/plat-s3c24xx/Makefile               |    6 ----
 arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c |   36 ------------------------
 arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c   |   38 --------------------------
 arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c    |   36 ------------------------
 drivers/spi/spi-s3c24xx.c                    |    2 +-
 8 files changed, 2 insertions(+), 176 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/spi.h
 delete mode 100644 arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
 delete mode 100644 arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c
 delete mode 100644 arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c

-- 
1.7.2.3
