From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 May 2016 14:34:17 +0200
Subject: [RFC v2 04/13] power: pwrseq: Enable COMPILE_TEST for drivers
In-Reply-To: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462451666-17945-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow build testing for power sequence drivers.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/pwrseq/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
index b5d2d6c65f28..4731ba01a958 100644
--- a/drivers/power/pwrseq/Kconfig
+++ b/drivers/power/pwrseq/Kconfig
@@ -9,7 +9,7 @@ if POWER_SEQ
 config POWER_SEQ_EMMC
 	tristate "HW reset support for eMMC"
 	default y
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  This selects Hardware reset support aka pwrseq-emmc for eMMC
 	  devices. By default this option is set to y.
@@ -20,7 +20,7 @@ config POWER_SEQ_EMMC
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
