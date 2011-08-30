From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Aug 2011 23:21:08 -0300
Subject: [PATCH] ARM: mx25: Fix build by providing MX25_IIM_BASE_ADDR
	definition
Message-ID: <1314670868-13457-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d27536c6 (ARM: mx25: Print silicon revision on boot) missed to include 
MX25_IIM_BASE_ADDR and caused the following build error:

  CC      arch/arm/mach-imx/cpu-imx25.o
arch/arm/mach-imx/cpu-imx25.c: In function 'mx25_read_cpu_rev':
arch/arm/mach-imx/cpu-imx25.c:23: error: 'MX25_IIM_BASE_ADDR' undeclared (first use in this function)
arch/arm/mach-imx/cpu-imx25.c:23: error: (Each undeclared identifier is reported only once
arch/arm/mach-imx/cpu-imx25.c:23: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-imx/cpu-imx25.o] Error 1
make: *** [arch/arm/mach-imx] Error 2

Fix the build by providing the missing definition.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/include/mach/mx25.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 8dcab80..ccebf5b 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -41,6 +41,7 @@
 #define MX25_SSI2_BASE_ADDR		0x50014000
 #define MX25_SSI1_BASE_ADDR		0x50034000
 #define MX25_NFC_BASE_ADDR		0xbb000000
+#define MX25_IIM_BASE_ADDR		0x53ff0000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
 #define MX25_ESDHC1_BASE_ADDR		0x53fb4000
 #define MX25_ESDHC2_BASE_ADDR		0x53fb8000
-- 
1.6.0.4
