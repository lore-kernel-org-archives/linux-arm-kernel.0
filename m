From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 19 Mar 2015 09:19:17 +0800
Subject: [PATCH 06/12] Doc: usb: ci-hdrc-imx: add ahb-burst-config for binding
 doc
In-Reply-To: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426727963-32280-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is used to change ahb burst configuration for platforms.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
index c21171e..a548502 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
@@ -22,6 +22,8 @@ Optional properties:
 - tpl-support: TPL (Targeted Peripheral List) feature for targeted hosts
 - gadget-itc-setting: the ITC setting for gadget, the required value
   should be aligned with ITC bits at register USBCMD.
+- ahb-burst-config: it is vendor dependent, the required value should be
+  aligned with AHBBRST at SBUSCFG, the range is from 0x0 to 0x7.
 
 Examples:
 usb at 02184000 { /* USB OTG */
@@ -35,4 +37,5 @@ usb at 02184000 { /* USB OTG */
 	maximum-speed = "full-speed";
 	tpl-support;
 	gadget-itc-setting = <0x4>; /* 4 micro-frames */
+	ahb-burst-config = <0x0>; /* Incremental burst of unspecified length */
 };
-- 
1.9.1
