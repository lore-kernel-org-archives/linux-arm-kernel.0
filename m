From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 16 Feb 2014 18:32:24 +0100
Subject: [PATCH 0/2] ARM: SAMSUNG: move all arches to generic uncompress.h
Message-ID: <3594365.ORKU4Q2jDp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-06 Sachin Kamat posted two patches converting Exynos to use
the generic uncompress.h.

But in fact all Samsung platforms can go this route, as all Samsung
uncompress.h files are simply used to set up the serial port.

As the original patches were not yet applied, this series includes the
original Exynos-specific change.

Tested on a s3c2416 and s3c2442 based machine.

Heiko Stuebner (2):
  ARM: SAMSUNG: use generic uncompress.h
  ARM: SAMSUNG: remove all custom uncompress.h

 arch/arm/Kconfig.debug                          |   5 +-
 arch/arm/mach-exynos/include/mach/uncompress.h  |  48 -------
 arch/arm/mach-s3c24xx/include/mach/uncompress.h |  57 --------
 arch/arm/mach-s3c64xx/include/mach/uncompress.h |  31 -----
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |  34 -----
 arch/arm/mach-s5pc100/include/mach/uncompress.h |  30 ----
 arch/arm/mach-s5pv210/include/mach/uncompress.h |  28 ----
 arch/arm/plat-samsung/include/plat/uncompress.h | 175 ------------------------
 8 files changed, 3 insertions(+), 405 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/uncompress.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/uncompress.h

-- 
1.8.5.3
