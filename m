From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 12 Dec 2013 17:18:01 +0100
Subject: [PATCH 1/3] clk: samsung: exynos4: Fix definition of div_mmc_pre4
 divider
In-Reply-To: <1386865083-20082-1-git-send-email-t.figa@samsung.com>
References: <1386865083-20082-1-git-send-email-t.figa@samsung.com>
Message-ID: <1386865083-20082-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock was missing CLK_SET_RATE_PARENT flag, which caused rate
setting failures due to inability of reconfiguration of second
divider behind it.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index ad5ff50..d967571 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -530,7 +530,8 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(sclk_i2s1, "sclk_i2s1", "sclk_audio1", DIV_PERIL5, 0, 6),
 	DIV(sclk_i2s2, "sclk_i2s2", "sclk_audio2", DIV_PERIL5, 8, 6),
 	DIV(none, "div_mmc4", "mout_mmc4", DIV_FSYS3, 0, 4),
-	DIV(none, "div_mmc_pre4", "div_mmc4", DIV_FSYS3, 8, 8),
+	DIV_F(none, "div_mmc_pre4", "div_mmc4", DIV_FSYS3, 8, 8,
+			CLK_SET_RATE_PARENT, 0),
 	DIV(none, "div_uart0", "mout_uart0", DIV_PERIL0, 0, 4),
 	DIV(none, "div_uart1", "mout_uart1", DIV_PERIL0, 4, 4),
 	DIV(none, "div_uart2", "mout_uart2", DIV_PERIL0, 8, 4),
-- 
1.8.4.3
