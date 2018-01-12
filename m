From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 12 Jan 2018 17:02:08 +1100
Subject: [PATCH 2/2] dts: ARM: Aspeed: Enable USB ports on eval board
Message-ID: <1515736928.31850.93.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables both USB ports as host with EHCI and UHCI
attached to them.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 6946c8610c4c..0c3f14d05046 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -80,3 +80,21 @@
 		reg = <0x4d>;
 	};
 };
+
+&ehci0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2ah_default>;
+};
+
+&ehci1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2bh_default>;
+};
+
+&uhci {
+	status = "okay";
+
+	/* No pinctrl, this follows the above EHCI settings */
+};
