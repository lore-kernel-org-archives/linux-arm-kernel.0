From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Oct 2016 13:56:19 +0200
Subject: [PATCH] bus: qcom-ebi2: depend on ARCH_QCOM or COMPILE_TEST
Message-ID: <1475582179-5085-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This hides the option for people who do not want their Kconfig
vision cluttered (i.e. x86) and enables compile testing apart
from the supported main arch.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC people: please apply this to next/drivers as well
or as a fix depending on timing.
---
 drivers/bus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7010dcac9328..78751057164a 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -111,6 +111,7 @@ config OMAP_OCP2SCP
 config QCOM_EBI2
 	bool "Qualcomm External Bus Interface 2 (EBI2)"
 	depends on HAS_IOMEM
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Say y here to enable support for the Qualcomm External Bus
 	  Interface 2, which can be used to connect things like NAND Flash,
-- 
2.7.4
