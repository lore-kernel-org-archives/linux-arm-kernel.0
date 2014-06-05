From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu,  5 Jun 2014 17:48:46 +0200
Subject: [PATCH 9/9] ARM: dts: Berlin: enable USB on the BG2Q DMP
In-Reply-To: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401983326-19205-10-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the 2 available USB PHY and USB nodes on the Marvell Berlin BG2Q
DMP.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 2da9c41e29d8..4195874b9bed 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -7,6 +7,8 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
 #include "berlin2q.dtsi"
 
 / {
@@ -26,3 +28,21 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb_phy0 {
+	power-gpio = <&portb 8 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&usb_phy2 {
+	power-gpio = <&portb 12 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
-- 
1.9.1
