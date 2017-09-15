From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 10:33:49 +0200
Subject: [PATCH 1/9] clk: rockchip: add more rk3188 graphics clock ids
In-Reply-To: <20170915083357.11296-1-heiko@sntech.de>
References: <20170915083357.11296-1-heiko@sntech.de>
Message-ID: <20170915083357.11296-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ids for cif, v{d/e}pu clocks on rk3188. ACLK_CIF does get a needed
1 at it's end but that should be safe because no driver for the camera
interface has surfaced so far and the old vendor kernels for these socs
are based on linux-3.0 and still used board files then, so there really
are no previous users anywhere to be found.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/rk3188-cru-common.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
index eff4319d008b..b9462b7d3dfe 100644
--- a/include/dt-bindings/clock/rk3188-cru-common.h
+++ b/include/dt-bindings/clock/rk3188-cru-common.h
@@ -68,12 +68,14 @@
 #define ACLK_LCDC1		196
 #define ACLK_GPU		197
 #define ACLK_SMC		198
-#define ACLK_CIF		199
+#define ACLK_CIF1		199
 #define ACLK_IPP		200
 #define ACLK_RGA		201
 #define ACLK_CIF0		202
 #define ACLK_CPU		203
 #define ACLK_PERI		204
+#define ACLK_VEPU		205
+#define ACLK_VDPU		206
 
 /* pclk gates */
 #define PCLK_GRF		320
@@ -134,8 +136,11 @@
 #define HCLK_NANDC0		467
 #define HCLK_CPU		468
 #define HCLK_PERI		469
+#define HCLK_CIF1		470
+#define HCLK_VEPU		471
+#define HCLK_VDPU		472
 
-#define CLK_NR_CLKS		(HCLK_PERI + 1)
+#define CLK_NR_CLKS		(HCLK_VDPU + 1)
 
 /* soft-reset indices */
 #define SRST_MCORE		2
-- 
2.14.1
