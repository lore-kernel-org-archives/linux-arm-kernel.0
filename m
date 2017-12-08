From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri,  8 Dec 2017 22:54:15 +0100
Subject: [PATCH 1/5] arm: dts: sun8i: a83t: Add I2C0 node
In-Reply-To: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Message-ID: <20171208215419.30396-2-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C0 node for A83T.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 19acae1b4089..848cf3f19962 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -177,6 +177,17 @@
 			#dma-cells = <1>;
 		};
 
+		i2c0: i2c at 01c2ac00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun8i-a83t-mmc",
 				     "allwinner,sun7i-a20-mmc";
-- 
2.11.0
