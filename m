From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Jan 2017 08:08:55 +0100
Subject: [PATCH] bus: qcom_ebi2: default y if ARCH_QCOM
Message-ID: <20170112070855.22214-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we want this external bus to be available on multi_v7 builds,
set to default ARCH_QCOM so we get it selected whenever QCOM is
enabled.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Andy: I guess you could queue this to ARM SoC, they seem so manage
drivers/bus from there.
---
 drivers/bus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index b9e8cfc93c7e..0a52da439abf 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -112,6 +112,7 @@ config QCOM_EBI2
 	bool "Qualcomm External Bus Interface 2 (EBI2)"
 	depends on HAS_IOMEM
 	depends on ARCH_QCOM || COMPILE_TEST
+	default ARCH_QCOM
 	help
 	  Say y here to enable support for the Qualcomm External Bus
 	  Interface 2, which can be used to connect things like NAND Flash,
-- 
2.9.3
