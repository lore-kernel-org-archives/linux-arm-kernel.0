From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 3 Aug 2015 12:47:16 +0800
Subject: [PATCH v2 08/10] Doc: usb: ci-hdrc-usb2: add
 tx(rx)-burst-config-dword for binding doc
In-Reply-To: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
References: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1438577238-10153-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is used to override the default setting for burst size, changing
burst size takes effect only when the SBUSCFG.AHBBRST = 0.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index 3c377a3..0f0929c 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -34,6 +34,10 @@ Optional properties:
   should be aligned with ITC bits at register USBCMD.
 - ahb-burst-config: it is vendor dependent, the required value should be
   aligned with AHBBRST at SBUSCFG, the range is from 0x0 to 0x7.
+- tx-burst-size-dword: it is vendor dependent, the tx burst size in dword
+  (4 bytes).
+- rx-burst-size-dword: it is vendor dependent, the rx burst size in dword
+  (4 bytes).
 
 Example:
 
@@ -48,4 +52,6 @@ Example:
 		gadget-itc-setting = <0x4>; /* 4 micro-frames */
 		 /* Incremental burst of unspecified length */
 		ahb-burst-config = <0x0>;
+		tx-burst-size-dword = <0x10>; /* 64 bytes */
+		rx-burst-size-dword = <0x10>;
 	};
-- 
1.9.1
