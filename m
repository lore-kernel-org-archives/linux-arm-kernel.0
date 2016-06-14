From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Tue, 14 Jun 2016 14:17:36 +0300
Subject: [PATCH v2 2/4] ARM: dts: sun4i: Add NFC node to Allwinner A10 SoC
In-Reply-To: <1465903058-9211-1-git-send-email-mamlinav@gmail.com>
References: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
 <1465903058-9211-1-git-send-email-mamlinav@gmail.com>
Message-ID: <1465903058-9211-3-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

Add NAND Flash controller node definition to the A10 SoC.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e579bdd..308ed5d 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -719,6 +719,19 @@
 			#dma-cells = <2>;
 		};
 
+		nfc: nand at 01c03000 {
+			compatible = "allwinner,sun4i-a10-nand";
+			reg = <0x01c03000 0x1000>;
+			interrupts = <37>;
+			clocks = <&ahb_gates 13>, <&nand_clk>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma SUN4I_DMA_DEDICATED 3>;
+			dma-names = "rxtx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		spi0: spi at 01c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
-- 
2.7.3
