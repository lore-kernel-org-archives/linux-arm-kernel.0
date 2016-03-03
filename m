From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:40 +0900
Subject: [RFC 14/15] usb: xhci: mtk: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456992221-26712-15-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
direct dependencies.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/usb/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8c20ebbc049c..f759a778d606 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -45,6 +45,7 @@ config USB_XHCI_PLATFORM
 
 config USB_XHCI_MTK
 	tristate "xHCI support for Mediatek MT65xx"
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select MFD_SYSCON
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	---help---
-- 
2.5.0
