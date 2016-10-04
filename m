From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  4 Oct 2016 11:46:24 +0200
Subject: [PATCH 11/14] ARM: dts: sun8i: Add analog codec on prcm node
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Message-ID: <b845d118ae8443227f8537f539ada0a485ff0ec3.1475571575.git.mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The analog codec for sun8i used PRCM registers so it should be added
in the device tree as a subnode of the prcm entry.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 48fc24f..5197812 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -549,6 +549,13 @@
 				compatible = "allwinner,sun6i-a31-clock-reset";
 				#reset-cells = <1>;
 			};
+
+			codec_analog: codec_analog {
+				compatible = "allwinner,sun8i-codec-analog";
+				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+				clock-names = "apb", "codec";
+			};
 		};
 
 		cpucfg at 01f01c00 {
-- 
2.9.3
