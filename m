From: jc@linux.com (Jesse Chan)
Date: Mon, 20 Nov 2017 12:58:03 -0800
Subject: [PATCH] pinctrl: pxa: pxa2xx: add missing
 MODULE_DESCRIPTION/AUTHOR/LICENSE
Message-ID: <20171120205804.88061-1-jc@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index 866aa3ce1ac9..6cf0006d4c8d 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -436,3 +436,7 @@ int pxa2xx_pinctrl_exit(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pxa2xx_pinctrl_exit);
+
+MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
+MODULE_DESCRIPTION("Marvell PXA2xx pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1
