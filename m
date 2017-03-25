From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 02:23:15 +0800
Subject: [PATCH v5 7/9] clk: hi6220: add debug APB clock
In-Reply-To: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1490466197-29163-8-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug APB clock is absent in hi6220 driver, so this patch is to add
support for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/clk-hi6220.c       | 1 +
 include/dt-bindings/clock/hi6220-clock.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index c0e8e1f..2ae151c 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -134,6 +134,7 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
 	{ HI6220_UART4_PCLK,    "uart4_pclk",    "uart4_src",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 8,  0, },
 	{ HI6220_SPI_CLK,       "spi_clk",       "clk_150m",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 9,  0, },
 	{ HI6220_TSENSOR_CLK,   "tsensor_clk",   "clk_bus",        CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 12, 0, },
+	{ HI6220_DAPB_CLK,      "dapb_clk",      "cs_dapb",        CLK_SET_RATE_PARENT|CLK_IS_CRITICAL,   0x230, 18, 0, },
 	{ HI6220_MMU_CLK,       "mmu_clk",       "ddrc_axi1",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x240, 11, 0, },
 	{ HI6220_HIFI_SEL,      "hifi_sel",      "hifi_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 0,  0, },
 	{ HI6220_MMC0_SYSPLL,   "mmc0_syspll",   "syspll",         CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 1,  0, },
diff --git a/include/dt-bindings/clock/hi6220-clock.h b/include/dt-bindings/clock/hi6220-clock.h
index 6b03c84..b8ba665 100644
--- a/include/dt-bindings/clock/hi6220-clock.h
+++ b/include/dt-bindings/clock/hi6220-clock.h
@@ -124,7 +124,10 @@
 #define HI6220_CS_DAPB		57
 #define HI6220_CS_ATB_DIV	58
 
-#define HI6220_SYS_NR_CLKS	59
+/* gate clock */
+#define HI6220_DAPB_CLK		59
+
+#define HI6220_SYS_NR_CLKS	60
 
 /* clk in Hi6220 media controller */
 /* gate clocks */
-- 
2.7.4
