From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 10:12:48 +0200
Subject: [PATCH 7/8] ARM: gr8: Add UART3 pins
In-Reply-To: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb1e4a568bc16ada5254cad063f4afbaa1ca5906.1476951078.git-series.maxime.ripard@free-electrons.com>
Message-ID: <cc81030de43c26dfc15ad9a9e525188ad8fb8ec9.1476951078.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART3 pins were missing from the DTSI. Add them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/ntc-gr8.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
index 52c150592953..4480ffadc42d 100644
--- a/arch/arm/boot/dts/ntc-gr8.dtsi
+++ b/arch/arm/boot/dts/ntc-gr8.dtsi
@@ -895,6 +895,20 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			uart3_pins_a: uart3 at 1 {
+				allwinner,pins = "PG9", "PG10";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_cts_rts_pins_a: uart3-cts-rts at 0 {
+				allwinner,pins = "PG11", "PG12";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		pwm: pwm at 01c20e00 {
-- 
git-series 0.8.10
