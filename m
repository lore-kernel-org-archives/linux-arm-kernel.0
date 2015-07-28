From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 28 Jul 2015 21:33:08 +0800
Subject: [PATCH 1/4] clk: imx: move imx_clk_gate_x into one place
In-Reply-To: <1438090391-30329-1-git-send-email-aisheng.dong@freescale.com>
References: <1438090391-30329-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1438090391-30329-2-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move imx_clk_gate_x api into one place for better code maintenance.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/imx/clk.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 1049b0c..cda8756 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -50,21 +50,6 @@ struct clk * imx_obtain_fixed_clock(
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
 
-static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
-{
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0, &imx_ccm_lock, NULL);
-}
-
-static inline struct clk *imx_clk_gate2_shared(const char *name,
-		const char *parent, void __iomem *reg, u8 shift,
-		unsigned int *share_count)
-{
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0, &imx_ccm_lock, share_count);
-}
-
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
@@ -118,6 +103,21 @@ static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, 0, &imx_ccm_lock, NULL);
+}
+
+static inline struct clk *imx_clk_gate2_shared(const char *name,
+		const char *parent, void __iomem *reg, u8 shift,
+		unsigned int *share_count)
+{
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, 0, &imx_ccm_lock, share_count);
+}
+
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
-- 
1.9.1
