From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Tue, 3 Jun 2014 15:54:28 +0900
Subject: [PATCH v2 2/2] arm: shmobile: r8a7790: add USB3.0 node to r8a7790.dtsi
Message-ID: <538D7124.60709@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node depends on a generic phy driver of usb.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e06c486..985c253 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -902,4 +902,14 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	xhci: usb at ee000000 {
+		compatible = "renesas,xhci-r8a7790";
+		reg = <0 0xee000000 0 0xc00>;
+		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
+		phys = <&usbphy 1 1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
 };
-- 
1.7.9.5
