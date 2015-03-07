From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  7 Mar 2015 20:01:20 +0100
Subject: [PATCH 3/7] ARM: dts: sun5i: Add mmc2 pinmux settings
In-Reply-To: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425754884-7875-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add A13 mmc2 pinmux settings, note these are for a 8bit bus.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 416c4de..244d896 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -469,6 +469,15 @@
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			mmc2_pins_a: mmc2 at 0 {
+				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
+					"PC10", "PC11", "PC12", "PC13",
+					"PC14", "PC15";
+				allwinner,function = "mmc2";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.3.1
