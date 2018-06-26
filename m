From: mine260309@gmail.com (Lei YU)
Date: Tue, 26 Jun 2018 09:55:25 +0800
Subject: [PATCH] clk: aspeed: Fix SDCLK name
Message-ID: <1529978125-28712-1-git-send-email-mine260309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDCLK was named SDCLKCLK, and no one has used this yet.
Fix it.

Signed-off-by: Lei YU <mine260309@gmail.com>
---
 drivers/clk/clk-aspeed.c                 | 2 +-
 include/dt-bindings/clock/aspeed-clock.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 38b366b..f49c684 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -109,7 +109,7 @@ struct aspeed_clk_gate {
 	[ASPEED_CLK_GATE_RSACLK] =	{ 24, -1, "rsaclk-gate",	NULL,	0 }, /* RSA */
 	[ASPEED_CLK_GATE_UART3CLK] =	{ 25, -1, "uart3clk-gate",	"uart",	0 }, /* UART3 */
 	[ASPEED_CLK_GATE_UART4CLK] =	{ 26, -1, "uart4clk-gate",	"uart",	0 }, /* UART4 */
-	[ASPEED_CLK_GATE_SDCLKCLK] =	{ 27, 16, "sdclk-gate",		NULL,	0 }, /* SDIO/SD */
+	[ASPEED_CLK_GATE_SDCLK] =	{ 27, 16, "sdclk-gate",		NULL,	0 }, /* SDIO/SD */
 	[ASPEED_CLK_GATE_LHCCLK] =	{ 28, -1, "lhclk-gate",		"lhclk", 0 }, /* LPC master/LPC+ */
 };
 
diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index 4476184..f437386 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -25,7 +25,7 @@
 #define ASPEED_CLK_GATE_RSACLK		19
 #define ASPEED_CLK_GATE_UART3CLK	20
 #define ASPEED_CLK_GATE_UART4CLK	21
-#define ASPEED_CLK_GATE_SDCLKCLK	22
+#define ASPEED_CLK_GATE_SDCLK		22
 #define ASPEED_CLK_GATE_LHCCLK		23
 #define ASPEED_CLK_HPLL			24
 #define ASPEED_CLK_AHB			25
-- 
1.9.1
