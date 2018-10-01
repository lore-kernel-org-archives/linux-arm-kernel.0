From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon,  1 Oct 2018 16:13:56 +0200
Subject: [PATCH v6 12/14] arm64: dts: marvell: add AP806 SEI subnode
In-Reply-To: <20181001141358.31508-1-miquel.raynal@bootlin.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
Message-ID: <20181001141358.31508-13-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the System Error Interrupt node, representing an IRQ chip which is
part of the GIC. The SEI node aggregates interrupts from the AP through
wired interrupts, and from the CPs through MSIs.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 176e38d54872..92215342b453 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -124,6 +124,15 @@
 				interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			sei: interrupt-controller at 3f0200 {
+				compatible = "marvell,ap806-sei";
+				reg = <0x3f0200 0x40>;
+				interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				msi-controller;
+			};
+
 			xor at 400000 {
 				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
 				reg = <0x400000 0x1000>,
-- 
2.17.1
