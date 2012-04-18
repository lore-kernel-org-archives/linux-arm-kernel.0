From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Apr 2012 19:46:28 +0200
Subject: [PATCH 04/10] MXS: Add data shared between imx-usb and EHCI driver
In-Reply-To: <1334771194-18688-1-git-send-email-marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-1-git-send-email-marex@denx.de>
Message-ID: <1334771194-18688-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common data shared between the MXS EHCI HCD driver
and the imx-usb driver. These data allow passing clock and memory stuff
from imx-usb driver into the host driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Lin Tony-B19295 <B19295@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Tony Lin <tony.lin@freescale.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 include/linux/fsl_devices.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index fffdf00..a1ed1a8 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -18,6 +18,7 @@
 #define _FSL_DEVICE_H_
 
 #include <linux/types.h>
+#include <linux/platform_device.h>
 
 /*
  * Some conventions on how we handle peripherals on Freescale chips
@@ -97,6 +98,15 @@ struct fsl_usb2_platform_data {
 	u32		pm_usbgenctrl;
 };
 
+struct imx_usb {
+	struct platform_device	*pdev;
+
+	struct clk		*clk;
+	struct resource		*mem_res;
+	void __iomem		*mem;
+	int			irq;
+};
+
 /* Flags in fsl_usb2_mph_platform_data */
 #define FSL_USB2_PORT0_ENABLED	0x00000001
 #define FSL_USB2_PORT1_ENABLED	0x00000002
-- 
1.7.9.5
