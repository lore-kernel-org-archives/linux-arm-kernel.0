From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Mon, 30 Apr 2012 11:53:43 +0200
Subject: [PATCH] imx21ads : Fix overlapping static i/o mappings
Message-ID: <1335779623-30383-1-git-send-email-jaccon.bastiaansen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The statically defined I/O memory regions for the i.MX21 on chip
peripherals and the on board I/O peripherals of the i.MX21ADS board
overlap. This results in a kernel crash during startup. This is fixed
by reducing the memory range for the on board I/O peripherals to the
actually required range.

Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
---
 arch/arm/mach-imx/mach-mx21ads.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index e432d4a..4460d25 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -32,7 +32,7 @@
  * Memory-mapped I/O on MX21ADS base board
  */
 #define MX21ADS_MMIO_BASE_ADDR   0xf5000000
-#define MX21ADS_MMIO_SIZE        SZ_16M
+#define MX21ADS_MMIO_SIZE        0xc00000
 
 #define MX21ADS_REG_ADDR(offset)    (void __force __iomem *) \
 		(MX21ADS_MMIO_BASE_ADDR + (offset))
-- 
1.7.1
