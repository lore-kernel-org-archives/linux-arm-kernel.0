From: sunjg79@163.com (sunjg79 at 163.com)
Date: Fri,  4 May 2018 16:56:30 +0800
Subject: [PATCH] clk: hisilicon: add missing usb3 clocks for Hi3798CV200 SoC
Message-ID: <1525424190-15619-1-git-send-email-sunjg79@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianguo Sun <sunjianguo1@huawei.com>

There are two USB3 host controllers on Hi3798CV200 SoC.
This commit adds missing clocks for them.

Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
---
 drivers/clk/hisilicon/crg-hi3798cv200.c | 17 +++++++++++++++++
 include/dt-bindings/clock/histb-clock.h |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index 743eec1..4fe0b2a 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -186,6 +186,23 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xbc, 0, 0 },
 	{ HISTB_USB2_PHY2_REF_CLK, "clk_u2_phy2_ref", "24m",
 		CLK_SET_RATE_PARENT, 0xbc, 2, 0 },
+	/* USB3 */
+	{ HISTB_USB3_BUS_CLK, "clk_u3_bus", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 0, 0 },
+	{ HISTB_USB3_UTMI_CLK, "clk_u3_utmi", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 4, 0 },
+	{ HISTB_USB3_PIPE_CLK, "clk_u3_pipe", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 3, 0 },
+	{ HISTB_USB3_SUSPEND_CLK, "clk_u3_suspend", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 2, 0 },
+	{ HISTB_USB3_BUS_CLK1, "clk_u3_bus1", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 16, 0 },
+	{ HISTB_USB3_UTMI_CLK1, "clk_u3_utmi1", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 20, 0 },
+	{ HISTB_USB3_PIPE_CLK1, "clk_u3_pipe1", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 19, 0 },
+	{ HISTB_USB3_SUSPEND_CLK1, "clk_u3_suspend1", NULL,
+		CLK_SET_RATE_PARENT, 0xb0, 18, 0 },
 };
 
 static struct hisi_clock_data *hi3798cv200_clk_register(
diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
index fab30b3..136de24 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -62,6 +62,14 @@
 #define HISTB_USB2_PHY1_REF_CLK		40
 #define HISTB_USB2_PHY2_REF_CLK		41
 #define HISTB_COMBPHY0_CLK		42
+#define HISTB_USB3_BUS_CLK		43
+#define HISTB_USB3_UTMI_CLK		44
+#define HISTB_USB3_PIPE_CLK		45
+#define HISTB_USB3_SUSPEND_CLK		46
+#define HISTB_USB3_BUS_CLK1		47
+#define HISTB_USB3_UTMI_CLK1		48
+#define HISTB_USB3_PIPE_CLK1		49
+#define HISTB_USB3_SUSPEND_CLK1		50
 
 /* clocks provided by mcu CRG */
 #define HISTB_MCE_CLK			1
-- 
2.7.4
