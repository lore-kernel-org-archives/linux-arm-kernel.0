From: manish.narani@xilinx.com (Manish Narani)
Date: Wed, 4 Jan 2017 18:52:56 +0530
Subject: [RFC PATCH] usb: dwc3: add support for OTG driver compilation
In-Reply-To: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
Message-ID: <1483536181-22356-2-git-send-email-mnarani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for OTG driver compilation and object
file creation

Signed-off-by: Manish Narani <mnarani@xilinx.com>
---
 drivers/usb/dwc3/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index ffca340..2d269ad 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -17,6 +17,10 @@ ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
 	dwc3-y				+= gadget.o ep0.o
 endif
 
+ifneq ($(CONFIG_USB_DWC3_DUAL_ROLE),)
+	dwc3-y				+= otg.o
+endif
+
 ifneq ($(CONFIG_USB_DWC3_ULPI),)
 	dwc3-y				+= ulpi.o
 endif
-- 
2.1.1
