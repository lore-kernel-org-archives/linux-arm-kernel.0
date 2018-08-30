From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 30 Aug 2018 21:01:18 +0200
Subject: [PATCH v4 11/13] ARM: dts: sun7i: a20: add sata-port/sata-phy nodes
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Message-ID: <20180830190120.722-12-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch convert sun7i-a20 sata to the new binding which use a sata
phy node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 8f7e1e29841f..8ff28f7afa85 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -667,6 +667,19 @@
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata_port: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata_phy>;
+			};
+		};
+
+		sata_phy: sata-phy at 1c180c0  {
+			compatible = "allwinner,sun4i-a10-sata-phy";
+			reg = <0x1c180c0 0x200>;
+			#phy-cells = <0>;
 		};
 
 		ehci1: usb at 1c1c000 {
-- 
2.16.4
