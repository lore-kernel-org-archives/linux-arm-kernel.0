From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Jan 2013 15:31:13 +0800
Subject: [PATCH v7 09/15] gpio: pl061: set initcall level to module init
In-Reply-To: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace subsys initcall by module initcall level. Since pinctrl
driver is already launched before gpio driver. It's unnecessary
to set gpio driver in subsys init call level.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pl061.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 8cfdf60..76adf33 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -393,7 +393,7 @@ static int __init pl061_gpio_init(void)
 {
 	return amba_driver_register(&pl061_gpio_driver);
 }
-subsys_initcall(pl061_gpio_init);
+module_init(pl061_gpio_init);
 
 MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
 MODULE_DESCRIPTION("PL061 GPIO driver");
-- 
1.7.10.4
