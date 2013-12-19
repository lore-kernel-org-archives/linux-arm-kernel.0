From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 19 Dec 2013 14:23:56 +0530
Subject: [PATCH Resend 2/7] clk: tegra: Staticize tegra_clk_periph_nodiv_ops
In-Reply-To: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
References: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1387443241-5694-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra_clk_periph_nodiv_ops is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/tegra/clk-periph.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index c534043c0481..356e9b804421 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -122,7 +122,7 @@ const struct clk_ops tegra_clk_periph_ops = {
 	.disable = clk_periph_disable,
 };
 
-const struct clk_ops tegra_clk_periph_nodiv_ops = {
+static const struct clk_ops tegra_clk_periph_nodiv_ops = {
 	.get_parent = clk_periph_get_parent,
 	.set_parent = clk_periph_set_parent,
 	.is_enabled = clk_periph_is_enabled,
-- 
1.7.9.5
