From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  2 Oct 2016 23:53:59 +0200
Subject: [PATCH] bus: qcom-ebi2: depend on HAS_IOMEM
Message-ID: <1475445239-25006-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After being asked to not depend on ARCH_QCOM* or similar,
unsurprisingly compilation fails on UM as it has no I/O
memory:

drivers/built-in.o: In function `qcom_ebi2_probe':
>> drivers/bus/qcom-ebi2.c:333: undefined reference to
   `devm_ioremap_resource'

Fix this by letting the Kconfig atleast depend on HAS_IOMEM.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC maintainers: please apply this directly on the offending
branch, or line it up for v4.9 fixes.
---
 drivers/bus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 5a2d47c71525..7010dcac9328 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -110,6 +110,7 @@ config OMAP_OCP2SCP
 
 config QCOM_EBI2
 	bool "Qualcomm External Bus Interface 2 (EBI2)"
+	depends on HAS_IOMEM
 	help
 	  Say y here to enable support for the Qualcomm External Bus
 	  Interface 2, which can be used to connect things like NAND Flash,
-- 
2.7.4
