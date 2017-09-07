From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu,  7 Sep 2017 15:04:53 +0200
Subject: [PATCH v2] arm64: dts: marvell: Fix A37xx UART0 register size
Message-ID: <20170907130453.25497-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: allen yan <yanwei@marvell.com>

Armada-37xx UART0 registers are 0x200 bytes wide. Right next to them are
the UART1 registers that should not be declared in this node.

Update the example in DT bindings document accordingly.

Signed-off-by: allen yan <yanwei@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---

Change since first version: re-added original author 'Signed-off-by'.

 Documentation/devicetree/bindings/serial/mvebu-uart.txt | 2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
index 6087defd9f93..d37fabe17bd1 100644
--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
@@ -8,6 +8,6 @@ Required properties:
 Example:
 	serial at 12000 {
 		compatible = "marvell,armada-3700-uart";
-		reg = <0x12000 0x400>;
+		reg = <0x12000 0x200>;
 		interrupts = <43>;
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 51763d674050..9e558801266a 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -129,7 +129,7 @@
 
 			uart0: serial at 12000 {
 				compatible = "marvell,armada-3700-uart";
-				reg = <0x12000 0x400>;
+				reg = <0x12000 0x200>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-- 
2.11.0
