From: stefan@agner.ch (Stefan Agner)
Date: Mon, 18 Aug 2014 22:07:16 +0200
Subject: [PATCH RESEND v2 6/7] ARM: dts: vf610-colibri: Add USB support
In-Reply-To: <cover.1408391385.git.stefan@agner.ch>
References: <cover.1408391385.git.stefan@agner.ch>
Message-ID: <675131705ee053a3adaaddff5ed1a379402a955f.1408391385.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB support for Colibri VF61 modules. The Colibri standard pinout
defines a pin for USB over-current. However, due to lack of pinmux
options, the USB hosts over-current protection signal of the Colibri
standard could not be connected to the PHY's over-current protection.
Hence we need to disable the over-current functionality of the USB
controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610-colibri.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri.dts b/arch/arm/boot/dts/vf610-colibri.dts
index aecc7db..f2a950d 100644
--- a/arch/arm/boot/dts/vf610-colibri.dts
+++ b/arch/arm/boot/dts/vf610-colibri.dts
@@ -69,6 +69,16 @@
 	status = "okay";
 };
 
+&usbdev0 {
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	disable-over-current;
+	status = "okay";
+};
+
 &iomuxc {
 	vf610-colibri {
 		pinctrl_esdhc1: esdhc1grp {
-- 
2.0.4
