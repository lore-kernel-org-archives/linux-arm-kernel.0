From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  2 May 2014 17:57:19 +0200
Subject: [PATCH v10 05/15] ARM: dts: sun4i: Add pin-muxing info for the mmc0
 controller
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399046249-19472-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc0 is the only controller actually being used on boards, so limit the
pin-muxing options to that.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index a0240b7..34651e9 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -565,6 +565,20 @@
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
+			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.9.0
