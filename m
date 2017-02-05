From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:40 +0100
Subject: [PATCH 4/9] ARM: sun5i: Add UART2 pin group
In-Reply-To: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <1da35c92609058bff5e2b4d56d8940c2919f594d.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's one UART2 pin group that can be used across all sun5i SoCs.
However, the A10s already has one pin group for that controller.

Change the index of the one in the A10s DTSI, and add the common one to
sun5i.dtsi

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  2 +-
 arch/arm/boot/dts/sun5i.dtsi                     | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 9fbeb584abf5..baee64d61f6d 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -257,7 +257,7 @@
 
 &uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins_a>;
+	pinctrl-0 = <&uart2_pins_b>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 0c08b6173d9c..5122d1179e59 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -151,7 +151,7 @@
 		function = "uart0";
 	};
 
-	uart2_pins_a: uart2 at 0 {
+	uart2_pins_b: uart2 at 1 {
 		pins = "PC18", "PC19";
 		function = "uart2";
 	};
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index fce3ec693531..cd951e2cdbe7 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -336,6 +336,16 @@
 				function = "spi2";
 			};
 
+			uart2_pins_a: uart2 at 0 {
+				pins = "PD2", "PD3";
+				function = "uart2";
+			};
+
+			uart2_cts_rts_pins_a: uart2-cts-rts at 0 {
+				pins = "PD4", "PD5";
+				function = "uart2";
+			};
+
 			uart3_pins_a: uart3 at 0 {
 				pins = "PG9", "PG10";
 				function = "uart3";
-- 
git-series 0.8.11
