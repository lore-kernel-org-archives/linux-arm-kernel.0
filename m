From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Mon, 28 Apr 2014 10:58:29 -0300
Subject: [PATCH 1/4] ARM: dts: am335x-bone-common: use phandles for USB and
 DMA refs
Message-ID: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use phandles instead of unit adresses to reference usb and dma nodes.
This makes the DT more robust and readable.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 2e7d932..b95bc9a 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -183,28 +183,28 @@
 &usb {
 	status = "okay";
 
-	control at 44e10620 {
+	&usb_ctrl_mod {
 		status = "okay";
 	};
 
-	usb-phy at 47401300 {
+	&usb0_phy {
 		status = "okay";
 	};
 
-	usb-phy at 47401b00 {
+	&usb1_phy {
 		status = "okay";
 	};
 
-	usb at 47401000 {
+	&usb0 {
 		status = "okay";
 	};
 
-	usb at 47401800 {
+	&usb1 {
 		status = "okay";
 		dr_mode = "host";
 	};
 
-	dma-controller at 47402000  {
+	&cppi41dma  {
 		status = "okay";
 	};
 };
-- 
1.9.2
