From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:36 +0900
Subject: [RFC 10/15] net: ethernet: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456992221-26712-11-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
direct dependencies.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/net/ethernet/hisilicon/Kconfig      | 1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 6 ++++++
 drivers/net/ethernet/ti/Kconfig             | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 74beb1867230..6a9c91781bf9 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -26,6 +26,7 @@ config HIX5HD2_GMAC
 config HIP04_ETH
 	tristate "HISILICON P04 Ethernet support"
 	select MARVELL_PHY
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	select HNS_MDIO
 	---help---
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index cec147d1d34f..d6902bf6e90f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -16,6 +16,7 @@ if STMMAC_ETH
 config STMMAC_PLATFORM
 	tristate "STMMAC Platform bus support"
 	depends on STMMAC_ETH
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	default y
 	---help---
@@ -41,6 +42,7 @@ config DWMAC_IPQ806X
 	tristate "QCA IPQ806x DWMAC support"
 	default ARCH_QCOM
 	depends on OF
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	help
 	  Support for QCA IPQ806X DWMAC Ethernet.
@@ -54,6 +56,7 @@ config DWMAC_LPC18XX
 	tristate "NXP LPC18xx/43xx DWMAC support"
 	default ARCH_LPC18XX
 	depends on OF
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	---help---
 	  Support for NXP LPC18xx/43xx DWMAC Ethernet.
@@ -73,6 +76,7 @@ config DWMAC_ROCKCHIP
 	tristate "Rockchip dwmac support"
 	default ARCH_ROCKCHIP
 	depends on OF
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	help
 	  Support for Ethernet controller on Rockchip RK3288 SoC.
@@ -84,6 +88,7 @@ config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
 	default ARCH_SOCFPGA
 	depends on OF
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	help
 	  Support for ethernet controller on Altera SOCFPGA
@@ -96,6 +101,7 @@ config DWMAC_STI
 	tristate "STi GMAC support"
 	default ARCH_STI
 	depends on OF
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	---help---
 	  Support for ethernet controller on STi SOCs.
diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index e7f0b7d95b65..ec56cebe929d 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -62,6 +62,7 @@ config TI_CPSW_ALE
 config TI_CPSW
 	tristate "TI CPSW Switch Support"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
 	select TI_CPSW_PHY_SEL
-- 
2.5.0
