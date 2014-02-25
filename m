From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Feb 2014 20:36:48 +0100
Subject: [PATCH v2 0/2] ARM: SAMSUNG: remove the rest of local uncompress.h
 files
Message-ID: <6973248.vNO4T7GhE6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two patches from Sachin Kamat already removed the Exynos-uncompress.h .
But in fact all Samsung platforms can use the generic uncompress code
without needing local implementation.

Therefore this two-part series removes the rest of the uncompress.h files
from all Samsung platforms.

Tested on a s3c2416 and s3c2442 based machine.

The patches should be applied on top of the patches from Sachin Kamat in
the v3.15-next/cleanup-samsung branch in the linux-samsung.git


Heiko Stuebner (2):
  ARM: SAMSUNG: use generic uncompress.h
  ARM: SAMSUNG: remove all custom uncompress.h

 arch/arm/Kconfig.debug                          |   4 +-
 arch/arm/mach-s3c24xx/include/mach/uncompress.h |  57 --------
 arch/arm/mach-s3c64xx/include/mach/uncompress.h |  31 -----
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |  34 -----
 arch/arm/mach-s5pc100/include/mach/uncompress.h |  30 ----
 arch/arm/mach-s5pv210/include/mach/uncompress.h |  28 ----
 arch/arm/plat-samsung/include/plat/uncompress.h | 175 ------------------------
 7 files changed, 2 insertions(+), 357 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/uncompress.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/uncompress.h

-- 
1.8.5.3
