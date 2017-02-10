From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Feb 2017 11:42:34 +0800
Subject: [PATCH] ARM: dts: sun5i-gr8: Rename pwm0_pins_a to pwm0_pins
Message-ID: <20170210034234.3612-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GR8, like other sun5i SoCs, has only 1 pin option for PWM0 output.
Other SoCs had named the pingroup "pwm0_pins" in their dtsi files, while
GR8 named it "pwm0_pins_a". When we switched to the new common sun5i
dtsi file, we forgot to rename the pingroup references in the GR8 board
dts files.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Fixes: a2138ce584d5 ("ARM: sun5i: gr8: Use common sun5i DTSI")

Since the broken patch is only in Maxime's tree, the above tag contains
the current commit hash in his tree. This is likely to change once
4.11-rc1 is released and the branch is rebased.

Maxime, maybe you could insert this patch before the "common sun5i"
patches, and do a bit of fixup?

Until then I'll keep this patch at the tip of our own sunxi-next branch.

ChenYu

 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts | 2 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index e5eb46b500ae..c55b11a4d3c7 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -171,7 +171,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins_a>, <&pwm1_pins>;
+	pinctrl-0 = <&pwm0_pins>, <&pwm1_pins>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/sun5i-gr8-evb.dts
index ebd8388e2ba1..558c16a30543 100644
--- a/arch/arm/boot/dts/sun5i-gr8-evb.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-evb.dts
@@ -281,7 +281,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins_a>;
+	pinctrl-0 = <&pwm0_pins>;
 	status = "okay";
 };
 
-- 
2.11.0
