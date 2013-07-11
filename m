From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 11 Jul 2013 14:32:14 +0530
Subject: [PATCH 6/6] clk: exynos-audss: Staticize exynos_audss_clk_init
In-Reply-To: <1373533334-5169-1-git-send-email-sachin.kamat@linaro.org>
References: <1373533334-5169-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1373533334-5169-7-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos_audss_clk_init() is used only in this file. Make it
static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos-audss.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 9b1bbd5..51b48da 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -62,7 +62,7 @@ static struct syscore_ops exynos_audss_clk_syscore_ops = {
 #endif /* CONFIG_PM_SLEEP */
 
 /* register exynos_audss clocks */
-void __init exynos_audss_clk_init(struct device_node *np)
+static void __init exynos_audss_clk_init(struct device_node *np)
 {
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
-- 
1.7.9.5
