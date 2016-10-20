From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 10:12:47 +0200
Subject: [PATCH 6/8] ARM: gr8: Add UART2 pins
In-Reply-To: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
Message-ID: <0c1f98755c7dd1764dcd89a599f182a0face286f.1476951078.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART2 pins were missing from the DTSI. Add them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/ntc-gr8.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
index fad7381630f3..52c150592953 100644
--- a/arch/arm/boot/dts/ntc-gr8.dtsi
+++ b/arch/arm/boot/dts/ntc-gr8.dtsi
@@ -881,6 +881,20 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			uart2_pins_a: uart2 at 1 {
+				allwinner,pins = "PD2", "PD3";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart2_cts_rts_pins_a: uart2-cts-rts at 0 {
+				allwinner,pins = "PD4", "PD5";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		pwm: pwm at 01c20e00 {
-- 
git-series 0.8.10
