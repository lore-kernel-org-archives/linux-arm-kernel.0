From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 10 Feb 2015 15:50:26 +0800
Subject: [PATCH v3 4/5] usb: phy: load usb phy earlier
In-Reply-To: <1423554627-694-1-git-send-email-zhangfei.gao@linaro.org>
References: <1423554627-694-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1423554627-694-5-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since phy is definitely used in usb controller, load the phy
earlier to make boot time shorter.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 2f1e2aa..d8926c6 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -5,6 +5,7 @@
 # Object files in subdirectories
 
 obj-$(CONFIG_USB)		+= core/
+obj-$(CONFIG_USB_SUPPORT)	+= phy/
 
 obj-$(CONFIG_USB_DWC3)		+= dwc3/
 obj-$(CONFIG_USB_DWC2)		+= dwc2/
@@ -48,7 +49,6 @@ obj-$(CONFIG_USB_MICROTEK)	+= image/
 obj-$(CONFIG_USB_SERIAL)	+= serial/
 
 obj-$(CONFIG_USB)		+= misc/
-obj-$(CONFIG_USB_SUPPORT)	+= phy/
 obj-$(CONFIG_EARLY_PRINTK_DBGP)	+= early/
 
 obj-$(CONFIG_USB_ATM)		+= atm/
-- 
1.9.1
