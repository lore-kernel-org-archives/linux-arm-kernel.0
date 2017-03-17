From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 17 Mar 2017 23:43:42 +0800
Subject: [PATCH 2/3] ARM: dts: sun8i: add pinmux for V3s mmc1
In-Reply-To: <20170317154343.39921-1-icenowy@aosc.xyz>
References: <20170317154343.39921-1-icenowy@aosc.xyz>
Message-ID: <20170317154343.39921-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC features 3 MMC controllers, mmc0 is used as the
MicroSD slot on Lichee Pi Zero, and on Lichee Pi Zero's dock mmc1 is
also soldered as a MicroSD slot.

Add the pinmux for mmc1, thus we can enable the MicroSD slot on the
Lichee Pi Zero dock.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 77bbf5ff9548..a74667ec1667 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -222,6 +222,14 @@
 				drive-strength = <30>;
 				bias-pull-up;
 			};
+
+			mmc1_pins: mmc1 at 0 {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.12.0
