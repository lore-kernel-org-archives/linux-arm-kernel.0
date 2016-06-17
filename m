From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 17 Jun 2016 18:09:16 +0800
Subject: [PATCH 03/12] power: pwrseq: Enable COMPILE_TEST for drivers
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1466158165-9380-4-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Allow build testing for power sequence drivers.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/power/pwrseq/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
index 7ecd66a..c7e9271 100644
--- a/drivers/power/pwrseq/Kconfig
+++ b/drivers/power/pwrseq/Kconfig
@@ -10,7 +10,7 @@ if POWER_SEQ
 config POWER_SEQ_EMMC
 	tristate "HW reset support for eMMC"
 	default y
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  This selects Hardware reset support aka pwrseq-emmc for eMMC
 	  devices. By default this option is set to y.
@@ -21,7 +21,7 @@ config POWER_SEQ_EMMC
 config POWER_SEQ_SIMPLE
 	tristate "Simple HW reset support for MMC"
 	default y
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  This selects simple hardware reset support aka pwrseq-simple for MMC
 	  devices. By default this option is set to y.
-- 
1.9.1
