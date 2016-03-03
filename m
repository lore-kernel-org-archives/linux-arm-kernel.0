From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:31 +0900
Subject: [RFC 05/15] phy: hi6220: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456992221-26712-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
direct dependencies.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 0124d17bd9fe..cfdb3551a675 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -225,6 +225,7 @@ config PHY_MT65XX_USB3
 config PHY_HI6220_USB
 	tristate "hi6220 USB PHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
-- 
2.5.0
