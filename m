From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Mon, 28 Apr 2014 10:58:32 -0300
Subject: [PATCH 4/4] ARM: dts: am335x-igep0033: use phandles for USB and DMA
 refs
In-Reply-To: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1398693512-5355-4-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use phandles instead of unit adresses to reference usb and dma nodes.
This makes the DT more robust and readable.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/am335x-igep0033.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 9f22c18..81cf68b 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -201,28 +201,28 @@
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
