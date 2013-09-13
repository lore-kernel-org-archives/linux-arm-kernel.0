From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 13 Sep 2013 14:53:45 +0530
Subject: [PATCH 03/10] clk: tegra: Staticize local variables in clk-pll.c
In-Reply-To: <1379064232-10261-1-git-send-email-sachin.kamat@linaro.org>
References: <1379064232-10261-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1379064232-10261-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Local variables used only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/clk/tegra/clk-pll.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 197074a..76ed452 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1340,7 +1340,7 @@ struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
 }
 
 #ifdef CONFIG_ARCH_TEGRA_114_SOC
-const struct clk_ops tegra_clk_pllxc_ops = {
+static const struct clk_ops tegra_clk_pllxc_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_iddq_enable,
 	.disable = clk_pll_iddq_disable,
@@ -1349,7 +1349,7 @@ const struct clk_ops tegra_clk_pllxc_ops = {
 	.set_rate = clk_pllxc_set_rate,
 };
 
-const struct clk_ops tegra_clk_pllm_ops = {
+static const struct clk_ops tegra_clk_pllm_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_iddq_enable,
 	.disable = clk_pll_iddq_disable,
@@ -1358,7 +1358,7 @@ const struct clk_ops tegra_clk_pllm_ops = {
 	.set_rate = clk_pllm_set_rate,
 };
 
-const struct clk_ops tegra_clk_pllc_ops = {
+static const struct clk_ops tegra_clk_pllc_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pllc_enable,
 	.disable = clk_pllc_disable,
@@ -1367,7 +1367,7 @@ const struct clk_ops tegra_clk_pllc_ops = {
 	.set_rate = clk_pllc_set_rate,
 };
 
-const struct clk_ops tegra_clk_pllre_ops = {
+static const struct clk_ops tegra_clk_pllre_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_iddq_enable,
 	.disable = clk_pll_iddq_disable,
@@ -1376,7 +1376,7 @@ const struct clk_ops tegra_clk_pllre_ops = {
 	.set_rate = clk_pllre_set_rate,
 };
 
-const struct clk_ops tegra_clk_plle_tegra114_ops = {
+static const struct clk_ops tegra_clk_plle_tegra114_ops = {
 	.is_enabled =  clk_pll_is_enabled,
 	.enable = clk_plle_tegra114_enable,
 	.disable = clk_plle_tegra114_disable,
-- 
1.7.9.5
