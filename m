From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 12 Feb 2015 15:53:35 +0100
Subject: [PATCH v2 09/10] ARM: berlin: add BG2Q node for the nand
In-Reply-To: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1423752816-26219-10-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the nand controller of the Marvell Berlin BG2Q
SoC. It uses the pxa3xx nand driver, with a dedicated compatible.

Also add the corresponding pinmuxing configuration.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index e2f61f27944e..9f5d48b68e16 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -429,6 +429,19 @@
 			status = "disabled";
 		};
 
+		nand0: nand at f00000 {
+			compatible = "marvell,berlin2-nand";
+			reg = <0xf00000 0x10000>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_NFC>,
+				 <&chip CLKID_NFC_ECC>;
+			clock-names = "nfc", "ecc";
+
+			#address-cells = <1>;
+
+			status = "disabled";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.3.0
