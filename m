From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 23 Nov 2014 17:08:48 +0100
Subject: [PATCH] ARM: dts: meson: enable Ethernet controller
Message-ID: <1416758928-12640-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Ethernet controller to Meson DTS file and
enable it on the Geniatech ATV1200 board.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/boot/dts/meson.dtsi         | 11 +++++++++++
 arch/arm/boot/dts/meson6-atv1200.dts |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 03bcff8..4704b95 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -143,5 +143,16 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		ethmac: ethernet at c9410000 {
+			compatible = "amlogic,meson6-dwmac", "snps,dwmac";
+			reg = <0xc9410000 0x10000
+			       0xc1108108 0x4>;
+			interrupts = <0 8 1>;
+			interrupt-names = "macirq";
+			clocks = <&clk81>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+		};
 	};
 }; /* end of / */
diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/meson6-atv1200.dts
index d7d351a..1237faa 100644
--- a/arch/arm/boot/dts/meson6-atv1200.dts
+++ b/arch/arm/boot/dts/meson6-atv1200.dts
@@ -64,3 +64,7 @@
 &uart_AO {
 	status = "okay";
 };
+
+&ethmac {
+	status = "okay";
+};
-- 
1.9.1
