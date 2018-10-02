From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  2 Oct 2018 10:43:41 +0200
Subject: [PATCH 2/2] arm64: dts: meson-axg: s400: disable emmc
In-Reply-To: <20181002084341.5487-1-jbrunet@baylibre.com>
References: <20181002084341.5487-1-jbrunet@baylibre.com>
Message-ID: <20181002084341.5487-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While it is possible to rework the s400 board to solder an eMMC on it,
it is not the default option and most boards are fitted with a NAND
instead.

Let's disable the emmc device by default to reflect this. The board
equipped with an eMMC will just have to alter the DT in the
bootloader, like we do for the reserved memory regions.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 166ab598395e..c74ff1efebb8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -479,7 +479,7 @@
 
 /* emmc storage */
 &sd_emmc_c {
-	status = "okay";
+	status = "disabled";
 	pinctrl-0 = <&emmc_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
-- 
2.17.1
