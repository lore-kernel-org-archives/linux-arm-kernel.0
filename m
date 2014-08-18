From: stefan@agner.ch (Stefan Agner)
Date: Mon, 18 Aug 2014 22:07:17 +0200
Subject: [PATCH RESEND v2 7/7] ARM: dts: vf610-twr: Add USB support
In-Reply-To: <cover.1408391385.git.stefan@agner.ch>
References: <cover.1408391385.git.stefan@agner.ch>
Message-ID: <07491836b9c23a82b7a33972a5c71f2676ceaf71.1408391385.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB support for Freescale Vybrid tower. The USB hosts over-current
protection signal is not connected is not connected to the PHY's over-
current protection, hence we need to disable it.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610-twr.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 11d7334..c709dc3 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -265,3 +265,13 @@
 	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
+
+&usbdev0 {
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	disable-over-current;
+	status = "okay";
+};
-- 
2.0.4
