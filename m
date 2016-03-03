From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:37 +0900
Subject: [RFC 11/15] power: reset: keystone: Add missing MFD_SYSCON dependency
 on HAS_IOMEM
In-Reply-To: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456992221-26712-12-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
direct dependencies.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 0a6408a39c66..0f34846ae80d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -141,6 +141,7 @@ config POWER_RESET_XGENE
 config POWER_RESET_KEYSTONE
 	bool "Keystone reset driver"
 	depends on ARCH_KEYSTONE
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	help
 	  Reboot support for the KEYSTONE SoCs.
-- 
2.5.0
