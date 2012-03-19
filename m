From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 11:36:00 -0600
Subject: [PATCH] gpio: tegra: tegra_gpio_config shouldn't be __init
Message-ID: <1332178560-15658-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is called from non-__init context, just like
tegra_gpio_enable()/disable(). Remove the __init annotation to avoid
section mismatch warnings during compile.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/gpio/gpio-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 636be99..32de670 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -461,7 +461,7 @@ static int __init tegra_gpio_init(void)
 }
 postcore_initcall(tegra_gpio_init);
 
-void __init tegra_gpio_config(struct tegra_gpio_table *table, int num)
+void tegra_gpio_config(struct tegra_gpio_table *table, int num)
 {
 	int i;
 
-- 
1.7.0.4
