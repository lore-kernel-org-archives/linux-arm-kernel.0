From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 21 Apr 2016 15:12:44 +0900
Subject: [PATCH] i2c: uniphier: add "\n" at the end of error log
Message-ID: <1461219164-8963-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 2 +-
 drivers/i2c/busses/i2c-uniphier.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 213ba55..aeead0d 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -524,7 +524,7 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number");
+		dev_err(dev, "failed to get IRQ number\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 89eaa8a..475a5eb 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -381,7 +381,7 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number");
+		dev_err(dev, "failed to get IRQ number\n");
 		return irq;
 	}
 
-- 
1.9.1
