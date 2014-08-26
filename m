From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 26 Aug 2014 13:46:09 +0800
Subject: [PATCH resend 3/4] clk: hix5hd2: add watchdog0 clocks
In-Reply-To: <1409031970-4821-1-git-send-email-zhangfei.gao@linaro.org>
References: <1409031970-4821-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1409031970-4821-4-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guoxiong Yan <yanguoxiong@huawei.com>

hix5hd2 add watchdog0 clocks

Signed-off-by: Guoxiong Yan <yanguoxiong@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/clk/hisilicon/clk-hix5hd2.c       |    5 +++++
 include/dt-bindings/clock/hix5hd2-clock.h |    2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 9fa2eef..232c38a 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -95,6 +95,11 @@ static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
 	{ HIX5HD2_FWD_SYS_CLK, "clk_fwd_sys", "clk_fwd_bus", 0, 0xcc, 5, 0, },
 	{ HIX5HD2_MAC0_PHY_CLK, "clk_fephy", "clk_fwd_sys",
 		 CLK_SET_RATE_PARENT, 0x120, 0, 0, },
+	/* wdg0 */
+	{ HIX5HD2_WDG0_CLK, "clk_wdg0", "24m",
+		CLK_SET_RATE_PARENT, 0x178, 0, 0, },
+	{ HIX5HD2_WDG0_RST, "rst_wdg0", "clk_wdg0",
+		CLK_SET_RATE_PARENT, 0x178, 4, CLK_GATE_SET_TO_DISABLE, },
 };
 
 enum hix5hd2_clk_type {
diff --git a/include/dt-bindings/clock/hix5hd2-clock.h b/include/dt-bindings/clock/hix5hd2-clock.h
index 5bd4135..b8e3c9d 100644
--- a/include/dt-bindings/clock/hix5hd2-clock.h
+++ b/include/dt-bindings/clock/hix5hd2-clock.h
@@ -60,6 +60,8 @@
 #define HIX5HD2_SD_CIU_CLK		136
 #define HIX5HD2_SD_BIU_CLK		137
 #define HIX5HD2_SD_CIU_RST		138
+#define HIX5HD2_WDG0_CLK		139
+#define HIX5HD2_WDG0_RST		140
 
 /* complex */
 #define HIX5HD2_MAC0_CLK		192
-- 
1.7.9.5
