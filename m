From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Thu, 29 May 2014 20:06:02 +0900
Subject: [PATCH 2/2] arm: shmobile: r8a7791: add USB3.0 node to r8a7791.dtsi
Message-ID: <5387149A.4010503@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index c2b5b38..2855c1f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -906,4 +906,14 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	xhci: xhci at ee000000 {
+		compatible = "renesas,xhci-r8a7791";
+		reg = <0 0xee000000 0 0xc00>;
+		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
+		phys = <&usbphy 1 1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
 };
-- 
1.7.9.5
