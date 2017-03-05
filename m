From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  5 Mar 2017 21:37:08 +0800
Subject: [PATCH v2 11/12] ARM: dts: sun8i: add pinmux for V3s mmc1
In-Reply-To: <20170305133709.6288-1-icenowy@aosc.xyz>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
Message-ID: <20170305133709.6288-12-icenowy@aosc.xyz>
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
index 5fb6cb69f7bc..a39c26bceedc 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -234,6 +234,14 @@
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
2.11.1
