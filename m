From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 13:58:44 +0800
Subject: [Patch v2 10/14] usb: doc: phy-mxs: update binding for adding
 disconnect line property
In-Reply-To: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382421528-17897-11-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This property is used to disconnect line between USB PHY and
USB controller.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/mxs-phy.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
index 5837963..356c9b6 100644
--- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
+++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
@@ -9,6 +9,9 @@ mxs PHY verions.
 - reg: Should contain registers location and length
 - interrupts: Should contain phy interrupt
 - fsl,anatop: phandle for anatop register, it is only for mx6 SoC serial
+- disconnect-line-without-vbus: needs to disconnect
+connection between USB PHY and controller, it can avoid
+unexpected wakeup interrupt when the PHY is out of power
 
 Example:
 usbphy1: usbphy at 020c9000 {
@@ -16,4 +19,5 @@ usbphy1: usbphy at 020c9000 {
 	reg = <0x020c9000 0x1000>;
 	interrupts = <0 44 0x04>;
 	fsl,anatop = <&anatop>;
+	disconnect-line-without-vbus;
 };
-- 
1.7.1
