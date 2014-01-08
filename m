From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed,  8 Jan 2014 15:22:02 +0100
Subject: [RFC PATCH 7/9] ARM: dt/sunxi: add NFC node to Allwinner A20 SoC
In-Reply-To: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1389190924-26226-8-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND Flash controller node definition to the A20 SoC.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 8e4cdcc..c00a577 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -299,6 +299,17 @@
 		#size-cells = <1>;
 		ranges;
 
+		nfc: nand at 01c03000 {
+			compatible = "allwinner,sun4i-nfc";
+			reg = <0x01c03000 0x1000>;
+			interrupts = <0 37 1>;
+			clocks = <&ahb_gates 13>, <&nand_clk>;
+			clock-names = "ahb_clk", "sclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		emac: ethernet at 01c0b000 {
 			compatible = "allwinner,sun4i-emac";
 			reg = <0x01c0b000 0x1000>;
-- 
1.7.9.5
