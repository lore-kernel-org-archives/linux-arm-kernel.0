From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Apr 2014 13:01:25 +0200
Subject: [PATCH v8 05/17] ARM: dts: sun4i: Add pin-muxing info for the mmc0
 controller
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1398164497-14212-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc0 is the only controller actually being used on boards, so limit the
pin-muxing options to that.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index dce074b..29fd4f5 100644
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
+			mmc0_cd_pin_a: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.9.0
