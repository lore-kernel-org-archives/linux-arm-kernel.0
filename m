From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:18 +0800
Subject: [PATCH v2 1/9] ARM: mmp: fix build issue on mmp with device tree
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336134626-12262-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since irq_domain_add_simple() is removed, remove it in mmp-dt.c also.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/mmp-dt.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index 6707539..ca22e3c0 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -32,31 +32,9 @@ static const struct of_dev_auxdata mmp_auxdata_lookup[] __initconst = {
 	{}
 };
 
-static int __init mmp_intc_add_irq_domain(struct device_node *np,
-					   struct device_node *parent)
-{
-	irq_domain_add_simple(np, 0);
-	return 0;
-}
-
-static int __init mmp_gpio_add_irq_domain(struct device_node *np,
-					   struct device_node *parent)
-{
-	irq_domain_add_simple(np, IRQ_GPIO_START);
-	return 0;
-}
-
-static const struct of_device_id mmp_irq_match[] __initconst = {
-	{ .compatible = "mrvl,mmp-intc", .data = mmp_intc_add_irq_domain, },
-	{ .compatible = "mrvl,mmp-gpio", .data = mmp_gpio_add_irq_domain, },
-	{}
-};
-
 static void __init mmp_dt_init(void)
 {
 
-	of_irq_init(mmp_irq_match);
-
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     mmp_auxdata_lookup, NULL);
 }
-- 
1.7.5.4
