From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 19 Dec 2013 17:53:04 -0800
Subject: [PATCH 03/10] clk: tegra: Staticize local variables in clk-pll.c
In-Reply-To: <1381231068-6053-3-git-send-email-sachin.kamat@linaro.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
 <1381231068-6053-3-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20131220015304.18119.81485@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2013-10-08 04:17:41)
> Local variables used only in this file are made static.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Stephen Warren <swarren@nvidia.com>

I updated this patch to staticize tegra_clk_pllxc_ops after taking
Peter's Tegra pull request. Refreshed patch has been applied to clk-next
and a copy is found below. Let me know if you have any comments.

Regards,
Mike



From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Tue, 8 Oct 2013 16:47:41 +0530
Subject: [PATCH] clk: tegra: Staticize local variables in clk-pll.c

Local variables used only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
[mturquette at linaro.org: staticize struct clk_ops tegra_clk_pllxc_ops]
---
 drivers/clk/tegra/clk-pll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 2dd4322..0d20241 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1433,7 +1433,7 @@ struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
 }
 
 #if defined(CONFIG_ARCH_TEGRA_114_SOC) || defined(CONFIG_ARCH_TEGRA_124_SOC)
-const struct clk_ops tegra_clk_pllxc_ops = {
+static const struct clk_ops tegra_clk_pllxc_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_iddq_enable,
 	.disable = clk_pll_iddq_disable,
@@ -1442,7 +1442,7 @@ const struct clk_ops tegra_clk_pllxc_ops = {
 	.set_rate = clk_pllxc_set_rate,
 };
 
-const struct clk_ops tegra_clk_pllm_ops = {
+static const struct clk_ops tegra_clk_pllm_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_iddq_enable,
 	.disable = clk_pll_iddq_disable,
@@ -1451,7 +1451,7 @@ const struct clk_ops tegra_clk_pllm_ops = {
 	.set_rate = clk_pllm_set_rate,
 };
 
-const struct clk_ops tegra_clk_pllc_ops = {
+static const struct clk_ops tegra_clk_pllc_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pllc_enable,
 	.disable = clk_pllc_disable,
@@ -1460,7 +1460,7 @@ const struct clk_ops tegra_clk_pllc_ops = {
 	.set_rate = clk_pllc_set_rate,
 };
 
-const struct clk_ops tegra_clk_pllre_ops = {
+static const struct clk_ops tegra_clk_pllre_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_iddq_enable,
 	.disable = clk_pll_iddq_disable,
@@ -1469,7 +1469,7 @@ const struct clk_ops tegra_clk_pllre_ops = {
 	.set_rate = clk_pllre_set_rate,
 };
 
-const struct clk_ops tegra_clk_plle_tegra114_ops = {
+static const struct clk_ops tegra_clk_plle_tegra114_ops = {
 	.is_enabled =  clk_pll_is_enabled,
 	.enable = clk_plle_tegra114_enable,
 	.disable = clk_plle_tegra114_disable,
@@ -1731,7 +1731,7 @@ struct clk *tegra_clk_register_plle_tegra114(const char *name,
 #endif
 
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
-const struct clk_ops tegra_clk_pllss_ops = {
+static const struct clk_ops tegra_clk_pllss_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_iddq_enable,
 	.disable = clk_pll_iddq_disable,
-- 
1.8.3.2
