From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 17 Jun 2016 17:16:02 +0900
Subject: [PATCH] clk: samsung: exynos5433: use clock_ignore_unused flag for
 SPI3 related clocks
Message-ID: <1466151362-2881-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaehoon Chung <jh80.chung@samsung.com>

The SPI 3 bus uses two clocks, a bus clock and an input clock.
Do not disable the clocks when unused in order to allow access to
the SPI 3 device.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 128527b..7c1fa09 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -1641,11 +1641,12 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_IOCLK_SPI4, "sclk_ioclk_spi4", "ioclk_spi4_clk_in",
 			ENABLE_SCLK_PERIC, 21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_SPI3, "sclk_ioclk_spi3", "ioclk_spi3_clk_in",
-			ENABLE_SCLK_PERIC, 20, CLK_SET_RATE_PARENT, 0),
+			ENABLE_SCLK_PERIC, 20,
+			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPI4, "sclk_spi4", "sclk_spi4_peric", ENABLE_SCLK_PERIC,
 			19, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPI3, "sclk_spi3", "sclk_spi3_peric", ENABLE_SCLK_PERIC,
-			18, CLK_SET_RATE_PARENT, 0),
+			18, CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SCI, "sclk_sci", "div_sclk_sci", ENABLE_SCLK_PERIC,
 			17, 0, 0),
 	GATE(CLK_SCLK_SC_IN, "sclk_sc_in", "div_sclk_sc_in", ENABLE_SCLK_PERIC,
-- 
2.8.1
