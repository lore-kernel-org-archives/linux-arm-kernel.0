From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:12 +0100
Subject: [PATCH 13/29] ARM: dts: r7s72100: add mmcif to device tree
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <887862227ba397bc6b22147284cdccc60a87f72f.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index e18d4e645d6e..50f9f3bc109d 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -450,4 +450,16 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	mmcif: mmc at e804c800 {
+		compatible = "renesas,mmcif-r7s72100", "renesas,sh-mmcif";
+		reg = <0xe804c800 0x80>;
+		interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R7S72100_CLK_MMCIF>;
+		reg-io-width = <4>;
+		bus-width = <8>;
+		status = "disabled";
+	};
 };
-- 
2.7.0.rc3.207.g0ac5344
