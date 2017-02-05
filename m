From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:41 +0100
Subject: [PATCH 5/9] ARM: sun5i: Rename UART3 flow control pins
In-Reply-To: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <c4829b6aaf0590b3db09b0b99deab753c3cd5c1a.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART3 pin group for the CTS and RTS signals doesn't follow our usual
pattern. Rename it so that it matches.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 2 +-
 arch/arm/boot/dts/sun5i.dtsi        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index e86fa46fdd45..c9a18216674a 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -281,7 +281,7 @@
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins_a>,
-		    <&uart3_pins_cts_rts_a>;
+		    <&uart3_cts_rts_pins_a>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index cd951e2cdbe7..d4888e0a0a13 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -351,7 +351,7 @@
 				function = "uart3";
 			};
 
-			uart3_pins_cts_rts_a: uart3-cts-rts at 0 {
+			uart3_cts_rts_pins_a: uart3-cts-rts at 0 {
 				pins = "PG11", "PG12";
 				function = "uart3";
 			};
-- 
git-series 0.8.11
