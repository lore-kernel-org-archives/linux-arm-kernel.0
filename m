From: ping.bai@nxp.com (Bai Ping)
Date: Tue, 20 Mar 2018 10:24:02 +0800
Subject: [PATCH v6 2/4] clk: imx: add new gate/gate2 wrapper funtion
In-Reply-To: <1521512644-25265-1-git-send-email-ping.bai@nxp.com>
References: <1521512644-25265-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1521512644-25265-2-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new gate/gate2 wrapper function to register clocks with optional flags.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 change from v3->v4:
 - no
 change from v4->5:
 - optimize commit subject
 change from v5->v6:
 - no change
---
 drivers/clk/imx/clk.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d69c4bb..8076ec0 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -123,6 +123,13 @@ static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 			shift, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_gate_flags(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, unsigned long flags)
+{
+	return clk_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
+			shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -137,6 +144,13 @@ static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
 			shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
+static inline struct clk *imx_clk_gate2_flags(const char *name, const char *parent,
+		void __iomem *reg, u8 shift, unsigned long flags)
+{
+	return clk_register_gate2(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
+			shift, 0x3, 0, &imx_ccm_lock, NULL);
+}
+
 static inline struct clk *imx_clk_gate2_shared(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
-- 
1.9.1
