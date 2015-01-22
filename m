From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 Jan 2015 10:07:17 +0000
Subject: [PATCH 2/2] ARM: sti: Provide DT nodes for SBC SSC[0..2]
In-Reply-To: <1421921237-8991-1-git-send-email-lee.jones@linaro.org>
References: <1421921237-8991-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1421921237-8991-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Synchronous Serial Controller is used to provide SPI.

These are the ports which are located on the Stand-By Controller (SBC).

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index d52347a..eb0bde7 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -328,5 +328,36 @@
 
 			status = "disabled";
 		};
+
+		/* SBC SSC */
+		spi at 9540000 {
+			compatible = "st,comms-ssc4-spi";
+			reg = <0x9540000 0x110>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_sysin>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi at 9541000 {
+			compatible = "st,comms-ssc4-spi";
+			reg = <0x9541000 0x110>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_sysin>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi at 9542000 {
+			compatible = "st,comms-ssc4-spi";
+			reg = <0x9542000 0x110>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_sysin>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
