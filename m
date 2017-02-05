From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:37 +0100
Subject: [PATCH 1/9] ARM: sun5i: A10s: Switch the EMAC pins indices
In-Reply-To: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <8f51ef7e000e57e1fa861188d421ad1bfd9af86a.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the pins group for the EMAC can be used by all the SoCs of the sun5i
family, and as such can be moved to the common DTSI.

Unfortunately, this group is the second one we declare in our DT for now.
Make it the first one so that it's more logical and consistent with the
rest of our DTs before moving it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 2 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts         | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index d8245c6314a7..9fbeb584abf5 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -83,7 +83,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins_b>;
 	phy = <&phy1>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 2b8adda0deda..99c84e870d91 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -95,7 +95,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_b>;
+	pinctrl-0 = <&emac_pins_a>;
 	phy = <&phy1>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 24b0f5f556f8..df2ba63d4ff9 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -156,7 +156,7 @@
 		function = "uart2";
 	};
 
-	emac_pins_a: emac0 at 0 {
+	emac_pins_b: emac0 at 1 {
 		pins = "PA0", "PA1", "PA2",
 				"PA3", "PA4", "PA5", "PA6",
 				"PA7", "PA8", "PA9", "PA10",
@@ -165,7 +165,7 @@
 		function = "emac";
 	};
 
-	emac_pins_b: emac0 at 1 {
+	emac_pins_a: emac0 at 0 {
 		pins = "PD6", "PD7", "PD10",
 				"PD11", "PD12", "PD13", "PD14",
 				"PD15", "PD18", "PD19", "PD20",
-- 
git-series 0.8.11
