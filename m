From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  4 Jun 2012 15:27:46 +0200
Subject: [PATCH 3/3] ARM i.MX53: Fix PLL4 base address
In-Reply-To: <1338816466-2365-1-git-send-email-s.hauer@pengutronix.de>
References: <1338816466-2365-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1338816466-2365-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX53_DPLL4_BASE accidently returned the base address of PLL3.
Fix this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-imx/crm-regs-imx5.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/crm-regs-imx5.h b/arch/arm/mach-imx/crm-regs-imx5.h
index 5e11ba7..5e3f1f0 100644
--- a/arch/arm/mach-imx/crm-regs-imx5.h
+++ b/arch/arm/mach-imx/crm-regs-imx5.h
@@ -23,7 +23,7 @@
 #define MX53_DPLL1_BASE		MX53_IO_ADDRESS(MX53_PLL1_BASE_ADDR)
 #define MX53_DPLL2_BASE		MX53_IO_ADDRESS(MX53_PLL2_BASE_ADDR)
 #define MX53_DPLL3_BASE		MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
-#define MX53_DPLL4_BASE		MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
+#define MX53_DPLL4_BASE		MX53_IO_ADDRESS(MX53_PLL4_BASE_ADDR)
 
 /* PLL Register Offsets */
 #define MXC_PLL_DP_CTL			0x00
-- 
1.7.10
