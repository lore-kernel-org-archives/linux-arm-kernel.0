From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jan 2010 17:46:23 -0700
Subject: [PATCH 1/5] AM35xx: Add AM35xx specific control module registers
In-Reply-To: <20100112004326.24684.91321.stgit@localhost.localdomain>
References: <20100112004326.24684.91321.stgit@localhost.localdomain>
Message-ID: <20100112004621.24684.38120.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ranjith Lohithakshan <ranjithl@ti.com>

AM3517/05 has a few additional control module registers defined mainly
to control the new IP's. This patch adds support for those new registers.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/control.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index a745d62..61e7b8a 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -160,6 +160,14 @@
 #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
 #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
 
+/* AM35XX only CONTROL_GENERAL register offsets */
+#define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
+#define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
+#define AM35XX_CONTROL_DEVCONF3         (OMAP2_CONTROL_GENERAL + 0x0314)
+#define AM35XX_CONTROL_CBA_PRIORITY     (OMAP2_CONTROL_GENERAL + 0x0320)
+#define AM35XX_CONTROL_LVL_INTR_CLEAR   (OMAP2_CONTROL_GENERAL + 0x0324)
+#define AM35XX_CONTROL_IP_SW_RESET      (OMAP2_CONTROL_GENERAL + 0x0328)
+#define AM35XX_CONTROL_IPSS_CLK_CTRL    (OMAP2_CONTROL_GENERAL + 0x032C)
 
 /* 34xx PADCONF register offsets */
 #define OMAP343X_PADCONF_ETK(i)		(OMAP2_CONTROL_PADCONFS + 0x5a8 + \
@@ -257,6 +265,15 @@
 #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
 #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
 
+/* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
+#define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
+#define AM35XX_CPGMAC_VBUSP_CLK_SHIFT   1
+#define AM35XX_VPFE_VBUSP_CLK_SHIFT     2
+#define AM35XX_HECC_VBUSP_CLK_SHIFT     3
+#define AM35XX_USBOTG_FCLK_SHIFT        8
+#define AM35XX_CPGMAC_FCLK_SHIFT        9
+#define AM35XX_VPFE_FCLK_SHIFT          10
+
 /*
  * CONTROL OMAP STATUS register to identify OMAP3 features
  */
