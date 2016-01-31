From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 31 Jan 2016 09:21:04 +0800
Subject: [PATCH 12/14] ARM: dts: sun8i-a83t: Add RSB nodes to dtsi
In-Reply-To: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1454203266-4450-13-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for RSB
A83T RSB is compatible with A23 rsb.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 11be9e1..8c67c85 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -499,5 +499,19 @@
 				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 			};
 		};
+
+		r_rsb: i2c at 01f03400 {
+			compatible = "allwinner,sun8i-a23-rsb";
+			reg = <0x01f03400 0x400>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 3>;
+			clock-frequency = <3000000>;
+			resets = <&apb0_reset 3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_rsb_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 };
-- 
1.9.1
