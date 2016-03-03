From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:28 +0900
Subject: [RFC 02/15] dmaengine: nxp: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456992221-26712-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
direct dependencies.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index c77f214c9466..7fbf96bff280 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -290,6 +290,7 @@ config LPC18XX_DMAMUX
 	bool "NXP LPC18xx/43xx DMA MUX for PL080"
 	depends on ARCH_LPC18XX || COMPILE_TEST
 	depends on OF && AMBA_PL08X
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	help
 	  Enable support for DMA on NXP LPC18xx/43xx platforms
-- 
2.5.0
