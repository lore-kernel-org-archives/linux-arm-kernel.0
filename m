From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu,  7 Aug 2014 09:36:01 +0800
Subject: [PATCH v4 4/4] clk: hix5hd2: add I2C clocks
In-Reply-To: <1407375361-24958-1-git-send-email-zhangfei.gao@linaro.org>
References: <1407375361-24958-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1407375361-24958-5-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yan <sledge.yanwei@huawei.com>

hix5hd2 add I2C clocks (I2C0~i2C5)

Signed-off-by: Wei Yan <sledge.yanwei@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/clk/hisilicon/clk-hix5hd2.c       |   25 +++++++++++++++++++++++++
 include/dt-bindings/clock/hix5hd2-clock.h |   12 ++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index d6a2189..75efccb 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -100,6 +100,31 @@ static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
 		CLK_SET_RATE_PARENT, 0x178, 0, 0, },
 	{ HIX5HD2_WDG0_RST, "rst_wdg0", "clk_wdg0",
 		CLK_SET_RATE_PARENT, 0x178, 4, CLK_GATE_SET_TO_DISABLE, },
+	/* I2C */
+	{HIX5HD2_I2C0_CLK, "clk_i2c0", "100m",
+		 CLK_SET_RATE_PARENT, 0x06c, 4, 0, },
+	{HIX5HD2_I2C0_RST, "rst_i2c0", "clk_i2c0",
+		 CLK_SET_RATE_PARENT, 0x06c, 5, CLK_GATE_SET_TO_DISABLE, },
+	{HIX5HD2_I2C1_CLK, "clk_i2c1", "100m",
+		 CLK_SET_RATE_PARENT, 0x06c, 8, 0, },
+	{HIX5HD2_I2C1_RST, "rst_i2c1", "clk_i2c1",
+		 CLK_SET_RATE_PARENT, 0x06c, 9, CLK_GATE_SET_TO_DISABLE, },
+	{HIX5HD2_I2C2_CLK, "clk_i2c2", "100m",
+		 CLK_SET_RATE_PARENT, 0x06c, 12, 0, },
+	{HIX5HD2_I2C2_RST, "rst_i2c2", "clk_i2c2",
+		 CLK_SET_RATE_PARENT, 0x06c, 13, CLK_GATE_SET_TO_DISABLE, },
+	{HIX5HD2_I2C3_CLK, "clk_i2c3", "100m",
+		 CLK_SET_RATE_PARENT, 0x06c, 16, 0, },
+	{HIX5HD2_I2C3_RST, "rst_i2c3", "clk_i2c3",
+		 CLK_SET_RATE_PARENT, 0x06c, 17, CLK_GATE_SET_TO_DISABLE, },
+	{HIX5HD2_I2C4_CLK, "clk_i2c4", "100m",
+		 CLK_SET_RATE_PARENT, 0x06c, 20, 0, },
+	{HIX5HD2_I2C4_RST, "rst_i2c4", "clk_i2c4",
+		 CLK_SET_RATE_PARENT, 0x06c, 21, CLK_GATE_SET_TO_DISABLE, },
+	{HIX5HD2_I2C5_CLK, "clk_i2c5", "100m",
+		 CLK_SET_RATE_PARENT, 0x06c, 0, 0, },
+	{HIX5HD2_I2C5_RST, "rst_i2c5", "clk_i2c5",
+		 CLK_SET_RATE_PARENT, 0x06c, 1, CLK_GATE_SET_TO_DISABLE, },
 };
 
 enum hix5hd2_clk_type {
diff --git a/include/dt-bindings/clock/hix5hd2-clock.h b/include/dt-bindings/clock/hix5hd2-clock.h
index b8e3c9d..fd29c17 100644
--- a/include/dt-bindings/clock/hix5hd2-clock.h
+++ b/include/dt-bindings/clock/hix5hd2-clock.h
@@ -62,6 +62,18 @@
 #define HIX5HD2_SD_CIU_RST		138
 #define HIX5HD2_WDG0_CLK		139
 #define HIX5HD2_WDG0_RST		140
+#define HIX5HD2_I2C0_CLK		141
+#define HIX5HD2_I2C0_RST		142
+#define HIX5HD2_I2C1_CLK		143
+#define HIX5HD2_I2C1_RST		144
+#define HIX5HD2_I2C2_CLK		145
+#define HIX5HD2_I2C2_RST		146
+#define HIX5HD2_I2C3_CLK		147
+#define HIX5HD2_I2C3_RST		148
+#define HIX5HD2_I2C4_CLK		149
+#define HIX5HD2_I2C4_RST		150
+#define HIX5HD2_I2C5_CLK		151
+#define HIX5HD2_I2C5_RST		152
 
 /* complex */
 #define HIX5HD2_MAC0_CLK		192
-- 
1.7.9.5
