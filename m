From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 16 May 2013 11:57:06 +0200
Subject: [PATCH v2 1/6] usb: phy: samsung: Select common driver part implicitly
In-Reply-To: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
References: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368698231-24268-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since phy-samsung-usb library can be used only by phy-samsung-usb2 and
phy-samsung-usb3 drivers, there is no need to give explicit control over
its Kconfig symbol.

This patch makes CONFIG_SAMSUNG_USBPHY symbol hidden and selected
implicitly by CONFIG_SAMSUNG_USB2PHY and CONFIG_SAMSUNG_USB3PHY.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 371d0e7..a2b9e18 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -86,7 +86,7 @@ config OMAP_USB3
 	  on/off the PHY.
 
 config SAMSUNG_USBPHY
-	tristate "Samsung USB PHY Driver"
+	tristate
 	help
 	  Enable this to support Samsung USB phy helper driver for Samsung SoCs.
 	  This driver provides common interface to interact, for Samsung USB 2.0 PHY
-- 
1.8.2.1
