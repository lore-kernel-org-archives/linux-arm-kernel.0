From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 26 Apr 2014 12:16:19 +0200
Subject: [PATCH v9 15/17] ARM: dts: sun7i: Add pin-muxing info for the mmc
 controllers
In-Reply-To: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1398507381-5614-16-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds  pin-muxing info for the mmc controller / port combinations which
are known to be used on actual boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index d7e4cac..99e8336 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -689,6 +689,27 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
+
+			mmc0_cd_pin_a: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
+			mmc3_pins_a: mmc3 at 0 {
+				allwinner,pins = "PI4","PI5","PI6","PI7","PI8","PI9";
+				allwinner,function = "mmc3";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.9.0
