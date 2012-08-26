From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Sun, 26 Aug 2012 23:35:38 +0200
Subject: [PATCH] imx21ads : avoid overlapping static i/o mappings
Message-ID: <1346016938-28175-1-git-send-email-jaccon.bastiaansen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static I/O mappings for the cs89x0 ethernet controller and the
secondary AHB port 1 (SAHB1) overlapped, causing a kernel crash
at startup. This is fixed by mapping the cs89x0 to 0xf6000000 (which
is free to use according to arch/arm/plat-mxc/include/mach/hardware.h).

Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
---
 arch/arm/mach-imx/mach-mx21ads.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index ed22e3f..712c90e 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -31,7 +31,7 @@
 /*
  * Memory-mapped I/O on MX21ADS base board
  */
-#define MX21ADS_MMIO_BASE_ADDR   0xf5000000
+#define MX21ADS_MMIO_BASE_ADDR   0xf6000000
 #define MX21ADS_MMIO_SIZE        0xc00000
 
 #define MX21ADS_REG_ADDR(offset)    (void __force __iomem *) \
-- 
1.7.1
