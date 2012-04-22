From: marex@denx.de (Marek Vasut)
Date: Sun, 22 Apr 2012 14:59:20 +0200
Subject: [PATCH 04/11] MXS: Add data shared between imx-otg and EHCI driver
In-Reply-To: <1335099567-21056-1-git-send-email-marex@denx.de>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-1-git-send-email-marex@denx.de>
Message-ID: <1335099567-21056-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common data shared between the MXS EHCI HCD driver,
the MXS USB Gadget driver and the imx-otg driver. These data allow
passing clock and memory stuff from imx-otg driver into the
host/gadget driver.

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
 include/linux/fsl/mxs-usb.h |   46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 include/linux/fsl/mxs-usb.h

diff --git a/include/linux/fsl/mxs-usb.h b/include/linux/fsl/mxs-usb.h
new file mode 100644
index 0000000..8326a79
--- /dev/null
+++ b/include/linux/fsl/mxs-usb.h
@@ -0,0 +1,46 @@
+/*
+ * include/linux/fsl/mxs-usb.h
+ *
+ * Freescale i.MX USB driver shared data.
+ *
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
+ * on behalf of DENX Software Engineering GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __INCLUDE_LINUX_FSL_MXS_USB_H__
+#define __INCLUDE_LINUX_FSL_MXS_USB_H__
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+
+struct imx_usb {
+	struct platform_device	*pdev_host;
+	struct platform_device	*pdev_gadget;
+
+	struct clk		*clk;
+	struct resource		*mem_res;
+	void __iomem		*mem;
+	int			irq;
+};
+
+struct imx_usb_platform_data {
+	uint32_t		gpio_vbus;
+	bool			gpio_vbus_inverted;
+	bool			host_mode;
+};
+
+#endif /* __INCLUDE_LINUX_FSL_MXS_USB_H__ */
-- 
1.7.9.5
