From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu,  3 Feb 2011 13:55:28 +0000
Subject: [PATCH] ARM: SAMSUNG: Ensure struct sys_device is declared in
	plat/pm.h
Message-ID: <1296741328-29435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously we were relying on it being pulled in by other headers for
the prototype of s3c24xx_irq_suspend() and s3c24xx_irq_resume().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/include/plat/pm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index d9025e3..30518cc 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -17,6 +17,8 @@
 
 #include <linux/irq.h>
 
+struct sys_device;
+
 #ifdef CONFIG_PM
 
 extern __init int s3c_pm_init(void);
-- 
1.7.2.3
