From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:16 +0100
Subject: [PATCH 17/29] ARM: dts: r7s72100: add sdhi to device tree
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <66474697923cd166567b06b492e52adce12393eb.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index eab06701ef11..3dd427d68c83 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -470,4 +470,30 @@
 		bus-width = <8>;
 		status = "disabled";
 	};
+
+	sdhi0: sd at e804e000 {
+		compatible = "renesas,sdhi-r7s72100";
+		reg = <0xe804e000 0x100>;
+		interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&mstp12_clks R7S72100_CLK_SDHI0>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi1: sd at e804e800 {
+		compatible = "renesas,sdhi-r7s72100";
+		reg = <0xe804e800 0x100>;
+		interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&mstp12_clks R7S72100_CLK_SDHI1>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
 };
-- 
2.7.0.rc3.207.g0ac5344
