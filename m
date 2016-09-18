From: kettenis@openbsd.org (Mark Kettenis)
Date: Sun, 18 Sep 2016 19:25:15 +0200
Subject: [PATCH] ARM: dts: sun8i: Enable pull-ups for bananapi-m2-plus SD slot
Message-ID: <20160918172515.92984-1-kettenis@openbsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board doesn't seem to have external pull-ups and some (but not all) SD cards
don't work without pull-ups.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---

Tested with an OpenBSD kernel where enabling the pull-ups makes an older 2G
SanDisk card work.  A newer Samsung 32G microSD card doesn't seem to need
this.  Note that u-boot always enables the pull-ups and boots just fine off
said 2G SanDisk card.

 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index f3b1d5f..3737556 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -117,6 +117,10 @@
 	status = "okay";
 };
 
+&mmc0_pins_a {
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins_a>;
-- 
2.9.3
