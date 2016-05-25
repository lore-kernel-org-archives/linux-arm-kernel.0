From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 25 May 2016 14:58:52 +0900
Subject: [PATCH] pinctrl: digicolor: add missing platform_set_drvdata() call
Message-ID: <1464155932-25344-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gc_pinctrl_remove() calls platform_get_drvdata(), but I see neither
platform_set_drvdata() nor dev_set_drvdata() anywhere in this driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pinctrl-digicolor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
index 30ee564..c8073d4 100644
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -332,6 +332,8 @@ static int dc_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(pmap->pctl);
 	}
 
+	platform_set_drvdata(pdev, pmap);
+
 	return dc_gpiochip_add(pmap, pdev->dev.of_node);
 }
 
-- 
1.9.1
