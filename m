From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 17:12:49 +0200
Subject: [PATCH 21/27] arm64: dts: marvell: rename ap806 syscon node
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Message-ID: <20180421151255.29929-22-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In CP files, the syscons are called CP110_LABEL(syscon<x>) in case of
future additions. Use the same logic here to prepare the addition of a
second syscon to access both the thermal IP, the DFX server registers
and later probably other registers within this same memory area.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/arm/marvell/ap806-system-controller.txt         | 2 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index c95f3ac5c728..3e1ceba1ab84 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -79,7 +79,7 @@ Required properties:
 - offset: offset address inside the syscon block
 
 Example:
-ap_syscon: system-controller at 6f4000 {
+ap_syscon0: system-controller at 6f4000 {
 	compatible = "syscon", "simple-mfd";
 	reg = <0x6f4000 0x1000>;
 
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index ebda3edeceed..71208aba4468 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -238,7 +238,7 @@
 				status = "disabled";
 			};
 
-			ap_syscon: system-controller at 6f4000 {
+			ap_syscon0: system-controller at 6f4000 {
 				compatible = "syscon", "simple-mfd";
 				reg = <0x6f4000 0x2000>;
 
-- 
2.14.1
