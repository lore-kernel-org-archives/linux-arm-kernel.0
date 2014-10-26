From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Oct 2014 16:36:06 +0100
Subject: [PATCH 4/4] ARM: sun9i: optimus: Set UART0 muxing
In-Reply-To: <1414337766-23690-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1414337766-23690-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1414337766-23690-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the UART0 muxing, as set up by the bootloader.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 2 ++
 arch/arm/boot/dts/sun9i-a80.dtsi        | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index f83abab108b9..9ed60f3927a3 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -60,6 +60,8 @@
 
 	soc {
 		uart0: serial at 07000000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 9616dc71faf3..29fd38d9fc43 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -351,6 +351,13 @@
 			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
+
+			uart0_pins_a: uart0 at 0 {
+				allwinner,pins = "PH12", "PH13";
+				allwinner,function = "uart0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 07000000 {
-- 
2.1.1
