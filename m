From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Aug 2011 11:38:29 +0200
Subject: [PATCH 8/8] ARM: mxc: drop now unused function mxc_register_device
In-Reply-To: <1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110801093759.GD9250@pengutronix.de>
	<1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1312191509-21895-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices.c             |   14 --------------
 arch/arm/plat-mxc/include/mach/common.h |    1 -
 2 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
index 0d6ed31..5aaa8c5 100644
--- a/arch/arm/plat-mxc/devices.c
+++ b/arch/arm/plat-mxc/devices.c
@@ -23,20 +23,6 @@
 #include <linux/platform_device.h>
 #include <mach/common.h>
 
-int __init mxc_register_device(struct platform_device *pdev, void *data)
-{
-	int ret;
-
-	pdev->dev.platform_data = data;
-
-	ret = platform_device_register(pdev);
-	if (ret)
-		pr_debug("Unable to register platform device '%s': %d\n",
-			 pdev->name, ret);
-
-	return ret;
-}
-
 struct platform_device *__init imx_add_platform_device_dmamask(
 		const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4e3d978..91d810ce 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -66,7 +66,6 @@ extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
-extern int mxc_register_device(struct platform_device *pdev, void *data);
 extern void mxc_set_cpu_type(unsigned int type);
 extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
-- 
1.7.5.4
