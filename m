From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 Dec 2014 19:10:35 +0800
Subject: [PATCH] ARM: dts: sunxi: Fix usb-phy support for sun4i/sun5i
Message-ID: <1418901035-22900-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usbphy0 support in the sunxi usb-phy driver has been merged, but the
dtsi's for sun4i/sun5i haven't been updated. This results in the phy
driver failing to load, breaking usb support.

Fixes: 6827a46f5994 ('phy: sun4i: add support for USB phy0')
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

The phy-sun4i-usb usbphy0 update is merged into Linus's tree.
Please queue this one for 3.19 fixes.

---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 4 ++--
 arch/arm/boot/dts/sun5i-a10s.dtsi | 4 ++--
 arch/arm/boot/dts/sun5i-a13.dtsi  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7b4099fcf817..e3422309e54b 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -438,8 +438,8 @@
 			reg-names = "phy_ctrl", "pmu1", "pmu2";
 			clocks = <&usb_clk 8>;
 			clock-names = "usb_phy";
-			resets = <&usb_clk 1>, <&usb_clk 2>;
-			reset-names = "usb1_reset", "usb2_reset";
+			resets = <&usb_clk 0>, <&usb_clk 1>, <&usb_clk 2>;
+			reset-names = "usb0_reset", "usb1_reset", "usb2_reset";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 1b76667f3182..3c3c1920788a 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -390,8 +390,8 @@
 			reg-names = "phy_ctrl", "pmu1";
 			clocks = <&usb_clk 8>;
 			clock-names = "usb_phy";
-			resets = <&usb_clk 1>;
-			reset-names = "usb1_reset";
+			resets = <&usb_clk 0>, <&usb_clk 1>;
+			reset-names = "usb0_reset", "usb1_reset";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index c35217ea1f64..2448d7f38d6b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -349,8 +349,8 @@
 			reg-names = "phy_ctrl", "pmu1";
 			clocks = <&usb_clk 8>;
 			clock-names = "usb_phy";
-			resets = <&usb_clk 1>;
-			reset-names = "usb1_reset";
+			resets = <&usb_clk 0>, <&usb_clk 1>;
+			reset-names = "usb0_reset", "usb1_reset";
 			status = "disabled";
 		};
 
-- 
2.1.3
