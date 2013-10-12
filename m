From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:09:43 +0800
Subject: [PATCH 09/12] usb: phy-mxs: update binding for adding anatop phandle
In-Reply-To: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1381568986-19802-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add anatop phandle which is used to access anatop registers to
control PHY's power and other USB operations.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/mxs-phy.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
index 5835b27..1a9bd85 100644
--- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
+++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
@@ -4,10 +4,12 @@ Required properties:
 - compatible: Should be "fsl,imx23-usbphy"
 - reg: Should contain registers location and length
 - interrupts: Should contain phy interrupt
+- fsl,anatop: phandle for anatop register
 
 Example:
 usbphy1: usbphy at 020c9000 {
 	compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 	reg = <0x020c9000 0x1000>;
 	interrupts = <0 44 0x04>;
+	fsl,anatop = <&anatop>;
 };
-- 
1.7.1
