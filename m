From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 27 May 2015 14:31:05 +0200
Subject: [PATCH] soc: mediatek: Add compile dependency to pmic-wrapper
Message-ID: <1432729865-32319-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pmic-wrapper calls the reset controller. If CONFIG_RESET_CONTROLLER
is not set, compilation fails with:
drivers/soc/mediatek/mtk-pmic-wrap.c: In function ?pwrap_probe?:
drivers/soc/mediatek/mtk-pmic-wrap.c:836:2: error: implicit declaration of function ?devm_reset_control_get? [-Werror=implicit-function-declaration]

This patch sets the dependency in the Kconfig file.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index bcdb22d..3c18503 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -4,6 +4,7 @@
 config MTK_PMIC_WRAP
 	tristate "MediaTek PMIC Wrapper Support"
 	depends on ARCH_MEDIATEK
+	depends on RESET_CONTROLLER
 	select REGMAP
 	help
 	  Say yes here to add support for MediaTek PMIC Wrapper found
-- 
1.9.1
