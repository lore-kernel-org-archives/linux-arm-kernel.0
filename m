From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 15 Feb 2014 18:10:22 +0400
Subject: [PATCH] ARM: common/scoop.c: Remove redundant code
Message-ID: <1392473422-17274-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Statements following return will never be executed.
This patch removes this code.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/common/scoop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index a5c3dc3..6ef146e 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -232,8 +232,6 @@ static int scoop_probe(struct platform_device *pdev)
 
 	return 0;
 
-	if (devptr->gpio.base != -1)
-		temp = gpiochip_remove(&devptr->gpio);
 err_gpio:
 	platform_set_drvdata(pdev, NULL);
 err_ioremap:
-- 
1.8.3.2
