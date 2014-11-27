From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Nov 2014 11:43:54 +0000
Subject: [PATCH 2/4] spi: st: Provide Device Tree binding documentation
In-Reply-To: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1417088636-11994-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT documentation for the SPI portion of ST's SSC device.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-st.txt | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-st.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-st.txt b/Documentation/devicetree/bindings/spi/spi-st.txt
new file mode 100644
index 0000000..efef468e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-st.txt
@@ -0,0 +1,40 @@
+STMicroelectronics SSC (SPI) Controller
+---------------------------------------
+
+Required properties:
+- compatible	: "st,comms-ssc-spi" or "st,comms-ssc4-spi"
+- reg		: Offset and length of the device's register set
+- interrupts	: The interrupt specifier
+- clock-names	: Must contain "ssc"
+- clocks	: Must contain an entry for each name in clock-names
+		    See ../clk/*
+- pinctrl-names	: Uses "default", can use "sleep" if provided
+		    See ../pinctrl/pinctrl-binding.txt
+
+Optional properties:
+- cs-gpios	: List of GPIO chip selects
+		    See ../spi/spi-bus.txt
+
+Child nodes represent devices on the SPI bus
+  See ../spi/spi-bus.txt
+
+Example:
+	spi at 9840000 {
+		compatible	= "st,comms-ssc-spi";
+		reg		= <0x9840000 0x110>;
+		interrupts	= <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks		= <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+		clock-names	= "ssc";
+		pinctrl-0	= <&pinctrl_spi0_default>;
+		pinctrl-names	= "default";
+		cs-gpios	= <&pio17 5 0>;
+		#address-cells	= <1>;
+		#size-cells	= <0>;
+
+		st95hf at 0{
+			compatible		= "st,st95hf";
+			reg			= <0>;
+			spi-max-frequency	= <1000000>;
+			interrupts		= <2 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
-- 
1.9.1
