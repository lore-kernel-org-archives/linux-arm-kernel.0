From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:16 +0200
Subject: [PATCH] clk/versatile: export symbols for impd1
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The impd1 code on mach-integrator can be a loadable module,
so we have to export icst_clk_register, integrator_impd1_clk_init
and integrator_impd1_clk_exit.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/versatile/clk-icst.c  | 1 +
 drivers/clk/versatile/clk-impd1.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index a820b0c..7f3868a 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -160,3 +160,4 @@ struct clk *icst_clk_register(struct device *dev,
 
 	return clk;
 }
+EXPORT_SYMBOL_GPL(icst_clk_register);
diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index 31b44f0..264d8d5 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -133,6 +133,7 @@ void integrator_impd1_clk_init(void __iomem *base, unsigned int id)
 	for (i = 0; i < ARRAY_SIZE(imc->clks); i++)
 		clkdev_add(imc->clks[i]);
 }
+EXPORT_SYMBOL_GPL(integrator_impd1_clk_init);
 
 void integrator_impd1_clk_exit(unsigned int id)
 {
@@ -155,3 +156,4 @@ void integrator_impd1_clk_exit(unsigned int id)
 	kfree(imc->vco2name);
 	kfree(imc->vco1name);
 }
+EXPORT_SYMBOL_GPL(integrator_impd1_clk_exit);
-- 
1.8.3.2
