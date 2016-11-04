From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:20 +0100
Subject: [PATCH 21/29] ARM: dts: r8a7793: Enable VIN0-VIN2
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <06b64afa6e981b332dccadcf0b5d52139525b4f6.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index a7d11b9f3555..629d3d60d1cd 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -852,6 +852,33 @@
 		status = "disabled";
 	};
 
+	vin0: video at e6ef0000 {
+		compatible = "renesas,vin-r8a7793", "renesas,rcar-gen2-vin";
+		reg = <0 0xe6ef0000 0 0x1000>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7793_CLK_VIN0>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
+	vin1: video at e6ef1000 {
+		compatible = "renesas,vin-r8a7793", "renesas,rcar-gen2-vin";
+		reg = <0 0xe6ef1000 0 0x1000>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7793_CLK_VIN1>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
+	vin2: video at e6ef2000 {
+		compatible = "renesas,vin-r8a7793", "renesas,rcar-gen2-vin";
+		reg = <0 0xe6ef2000 0 0x1000>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7793_CLK_VIN2>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		status = "disabled";
+	};
+
 	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7793", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
2.7.0.rc3.207.g0ac5344
