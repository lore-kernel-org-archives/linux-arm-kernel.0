From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu,  5 Mar 2015 12:31:24 +0100
Subject: [PATCH v3 8/9] ARM: berlin: add BG2Q node for the nand
In-Reply-To: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425555085-29531-9-git-send-email-antoine.tenart@free-electrons.com>
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
index be5397288d24..aeb3a0ea0540 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -437,6 +437,19 @@
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
2.3.1
