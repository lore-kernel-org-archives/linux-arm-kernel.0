From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:40 +0100
Subject: [PATCH 03/21] clk: samsung: exynos4: Add missing mout_mipihsi clock
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing output of mux MIPIHSI which is needed for
div_mipihsi clock.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 8edd64c..42c098d 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -381,6 +381,7 @@ struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX(none, "mout_mmc2", group1_p4x12, SRC_FSYS, 8, 4),
 	MUX(none, "mout_mmc3", group1_p4x12, SRC_FSYS, 12, 4),
 	MUX(none, "mout_mmc4", group1_p4x12, SRC_FSYS, 16, 4),
+	MUX(none, "mout_mipihsi", aclk_p4412, SRC_FSYS, 24, 1),
 	MUX(none, "mout_uart0", group1_p4x12, SRC_PERIL0, 0, 4),
 	MUX(none, "mout_uart1", group1_p4x12, SRC_PERIL0, 4, 4),
 	MUX(none, "mout_uart2", group1_p4x12, SRC_PERIL0, 8, 4),
-- 
1.8.1.5
