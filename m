From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 May 2017 16:40:00 +0800
Subject: [PATCH 3/4] ARM: sun8i: v3s: add pinmux for mmc1
In-Reply-To: <20170515084001.63123-1-icenowy@aosc.io>
References: <20170515084001.63123-1-icenowy@aosc.io>
Message-ID: <20170515084001.63123-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dock board of Lichee Pi Zero features a MicroSD slot on MMC1, which
can be used with a MicroSD card or the MicroSD-slot Wi-Fi card provided
by Lichee Pi Zero.

Add pinmux for the mmc1 controller, and specify it in the mmc1 device
node as it's the only pinmux for mmc1.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index b9a3df941fb4..6ff50665e5e6 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -128,6 +128,8 @@
 			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -224,6 +226,14 @@
 				drive-strength = <30>;
 				bias-pull-up;
 			};
+
+			mmc1_pins: mmc1 {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.12.2
