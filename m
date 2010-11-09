From: baruch@tkos.co.il (Baruch Siach)
Date: Tue,  9 Nov 2010 08:47:55 +0200
Subject: [PATCH 2/2] imx: fix USB build when USB gadget is selected
In-Reply-To: <6c16c084bfda41cd104613bed66bbad7b5433c6d.1289285160.git.baruch@tkos.co.il>
References: <6c16c084bfda41cd104613bed66bbad7b5433c6d.1289285160.git.baruch@tkos.co.il>
Message-ID: <00929d858b30cf10e8a9e6a9dffd27d36b1abda4.1289285160.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 126512e3f274802ca65ebeca8660237f0361ad48 (USB: add platform glue driver
for FSL USB DR controller) broke i.MX build by selecting USB_FSL_MPH_DR_OF.

Cc: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/usb/gadget/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index b739ca8..5a858aa 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -158,7 +158,7 @@ config USB_GADGET_FSL_USB2
 	boolean "Freescale Highspeed USB DR Peripheral Controller"
 	depends on FSL_SOC || ARCH_MXC
 	select USB_GADGET_DUALSPEED
-	select USB_FSL_MPH_DR_OF
+	select USB_FSL_MPH_DR_OF if FSL_SOC
 	help
 	   Some of Freescale PowerPC processors have a High Speed
 	   Dual-Role(DR) USB controller, which supports device mode.
-- 
1.7.2.3
