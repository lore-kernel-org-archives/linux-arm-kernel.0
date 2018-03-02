From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  2 Mar 2018 14:44:36 +0100
Subject: [PATCH] ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate
Message-ID: <20180302134436.18844-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Different modules maybe installed by the user on the eMMC connector
of the odroid-c2. While the red modules are working without an issue,
it seems some black modules (apparently Samsung based) are having
issue at 200MHz

While the tuning algorithm introduced in v4.14 enables high speed modes
on every other tested designs, it seems a problem remains for this
particular combination of board and eMMC module.

Lowering the maximum frequency of the eMMC on this board until we can
figure out a better solution.

Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
Suggested-by: Ellie Reeves <ellierevves@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 73a030a5ecf3..43475139576c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -311,7 +311,7 @@
 	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
-	max-frequency = <200000000>;
+	max-frequency = <100000000>;
 	non-removable;
 	disable-wp;
 	cap-mmc-highspeed;
-- 
2.14.3
