From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 9 Sep 2011 17:17:48 +0800
Subject: [PATCH v4 2/3] ARM: i.MX5/mm: Remove MX51_DEBUG related mapping
In-Reply-To: <1315559869-24838-1-git-send-email-jason.hui@linaro.org>
References: <1315559869-24838-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1315559869-24838-3-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX51_DEBUG related mapping is dead code, no-one use it

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/mm.c                    |    1 -
 arch/arm/plat-mxc/include/mach/hardware.h |    1 -
 arch/arm/plat-mxc/include/mach/mx51.h     |   12 ------------
 3 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 999f0d3..0002b68 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -36,7 +36,6 @@ static struct map_desc mx50_io_desc[] __initdata = {
  */
 static struct map_desc mx51_io_desc[] __initdata = {
 	imx_map_entry(MX51, IRAM, MT_DEVICE),
-	imx_map_entry(MX51, DEBUG, MT_DEVICE),
 	imx_map_entry(MX51, AIPS1, MT_DEVICE),
 	imx_map_entry(MX51, SPBA0, MT_DEVICE),
 	imx_map_entry(MX51, AIPS2, MT_DEVICE),
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index a8bfd56..33728aa 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -82,7 +82,6 @@
  *	AIPS2	0x63f00000+0x100000	->	0xf5300000+0x100000
  * mx51:
  *	IRAM	0x1ffe0000+0x020000	->	0xf4fe0000+0x020000
- *	DEBUG	0x60000000+0x100000	->	0xf5000000+0x100000
  *	SPBA0	0x70000000+0x100000	->	0xf5400000+0x100000
  *	AIPS1	0x73f00000+0x100000	->	0xf5700000+0x100000
  *	AIPS2	0x83f00000+0x100000	->	0xf4300000+0x100000
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index dede19a..652f2b0 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -18,18 +18,6 @@
 #define MX51_GPU_CTRL_BASE_ADDR		0x30000000
 #define MX51_IPU_CTRL_BASE_ADDR		0x40000000
 
-#define MX51_DEBUG_BASE_ADDR		0x60000000
-#define MX51_DEBUG_SIZE			SZ_1M
-
-#define MX51_ETB_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x01000)
-#define MX51_ETM_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x02000)
-#define MX51_TPIU_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x03000)
-#define MX51_CTI0_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x04000)
-#define MX51_CTI1_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x05000)
-#define MX51_CTI2_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x06000)
-#define MX51_CTI3_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x07000)
-#define MX51_CORTEX_DBG_BASE_ADDR	(MX51_DEBUG_BASE_ADDR + 0x08000)
-
 /*
  * SPBA global module enabled #0
  */
-- 
1.7.4.1
