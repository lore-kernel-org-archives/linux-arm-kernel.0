From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 3 Jun 2011 16:10:15 -0300
Subject: [PATCH] ARM: mx53: Fix the chip select addresses
Message-ID: <1307128215-10482-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX53 has 4 chip selects (CS0 - CS3) and the valid combinations are:

- CS0 (128MB)
- CS0 (64MB), CS1 (64MB)
- CS0 (64MB), CS1 (32MB), CS2 (32MB)
- CS0 (32MB), CS1 (32MB), CS2 (32MB) , CS3 (32MB)

Fix these addresses and also take into account all the four possibilities.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/include/mach/mx53.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index ace1786..58ff0dd 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -147,12 +147,12 @@
  */
 #define MX53_CSD0_BASE_ADDR		0x90000000
 #define MX53_CSD1_BASE_ADDR		0xA0000000
-#define MX53_CS0_BASE_ADDR		0xB0000000
-#define MX53_CS1_BASE_ADDR		0xB8000000
-#define MX53_CS2_BASE_ADDR		0xC0000000
-#define MX53_CS3_BASE_ADDR		0xC8000000
-#define MX53_CS4_BASE_ADDR		0xCC000000
-#define MX53_CS5_BASE_ADDR		0xCE000000
+#define MX53_CS0_BASE_ADDR		0xF0000000
+#define MX53_CS1_32MB_BASE_ADDR	0xF2000000
+#define MX53_CS1_64MB_BASE_ADDR		0xF4000000
+#define MX53_CS2_64MB_BASE_ADDR		0xF4000000
+#define MX53_CS2_96MB_BASE_ADDR		0xF6000000
+#define MX53_CS3_BASE_ADDR		0xF6000000
 
 #define MX53_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX53_IO_ADDRESS(x)		IOMEM(MX53_IO_P2V(x))
-- 
1.6.0.4
