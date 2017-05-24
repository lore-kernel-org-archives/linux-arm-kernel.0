From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 20:13:19 +0800
Subject: [PATCH 2/3] ARM: sun8i: v3s: add PWM pinmux nodes
In-Reply-To: <20170524121320.4171-1-icenowy@aosc.io>
References: <20170524121320.4171-1-icenowy@aosc.io>
Message-ID: <20170524121320.4171-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s have two PWM channels, the first channel can be only at
PB4 pin, and the second channel PB5.

Add their pinmux configurations.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index bb080c4bd22c..db3328a2c89a 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -239,6 +239,16 @@
 				pins = "PC0", "PC1", "PC2", "PC3";
 				function = "spi0";
 			};
+
+			pwm0_pins: pwm0 {
+				pins = "PB4";
+				function = "pwm0";
+			};
+
+			pwm1_pins: pwm1 {
+				pins = "PB5";
+				function = "pwm1";
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.12.2
