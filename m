From: codekipper@gmail.com (codekipper at gmail.com)
Date: Fri, 27 Jan 2017 16:48:07 +0100
Subject: [linux-sunxi][PATCH 2/3] ARM: dts: sun8i-h3: Add the SPDIF block to
 the H3
In-Reply-To: <20170127154808.19229-1-codekipper@gmail.com>
References: <20170127154808.19229-1-codekipper@gmail.com>
Message-ID: <20170127154808.19229-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF transceiver controller block to the H3 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 6e250bd9a8a9..48f9a0419b82 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -462,6 +462,19 @@
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spdif: spdif at 01c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			resets = <&ccu RST_BUS_SPDIF>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma 2>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
 		pwm: pwm at 01c21400 {
 			compatible = "allwinner,sun8i-h3-pwm";
 			reg = <0x01c21400 0x8>;
-- 
2.11.0
