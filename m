From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 20 Feb 2014 13:14:33 +0800
Subject: [PATCH v10 04/15] usb: doc: phy-mxs: update binding for adding anatop
 phandle
In-Reply-To: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
References: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1392873284-9386-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add anatop phandle which is used to access anatop registers to
control PHY's power and other USB operations.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/mxs-phy.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
index b43d4c9e..fc6659d 100644
--- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
+++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
@@ -5,10 +5,12 @@ Required properties:
   for imx6dq and imx6dl, "fsl,imx6sl-usbphy" for imx6sl
 - reg: Should contain registers location and length
 - interrupts: Should contain phy interrupt
+- fsl,anatop: phandle for anatop register, it is only for imx6 SoC series
 
 Example:
 usbphy1: usbphy at 020c9000 {
 	compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 	reg = <0x020c9000 0x1000>;
 	interrupts = <0 44 0x04>;
+	fsl,anatop = <&anatop>;
 };
-- 
1.7.8
