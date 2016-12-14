From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Wed, 14 Dec 2016 15:57:24 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Change node name for pwrseq pin on
 Olinuxino-lime2-emmc
Message-ID: <20161214145724.42745-1-manu@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The node name for the power seq pin is mmc2 at 0 like the mmc2_pins_a one.
This makes the original node (mmc2_pins_a) scrapped out of the dtb and
result in a unusable eMMC if U-Boot didn't configured the pins to the
correct functions.

Changes since v1:
 * Rename the node mmc2-rst-pin

Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
index 5ea4915..10d3074 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
@@ -56,7 +56,7 @@
 };
 
 &pio {
-	mmc2_pins_nrst: mmc2 at 0 {
+	mmc2_pins_nrst: mmc2-rst-pin {
 		allwinner,pins = "PC16";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-- 
2.9.2
