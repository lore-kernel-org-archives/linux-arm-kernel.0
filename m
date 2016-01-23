From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 24 Jan 2016 04:25:13 +0900
Subject: [PATCH] pinctrl: pxa: export pxa2xx_pinctrl_init()
Message-ID: <1453577113-14423-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building pinctrl-pxa27x.c as a module causes a link error:

ERROR: "pxa2xx_pinctrl_init" [drivers/pinctrl/pxa/pinctrl-pxa27x.ko] undefined!

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index d90e205..216f227 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -426,6 +426,7 @@ int pxa2xx_pinctrl_init(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL(pxa2xx_pinctrl_init);
 
 int pxa2xx_pinctrl_exit(struct platform_device *pdev)
 {
-- 
1.9.1
