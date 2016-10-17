From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Oct 2016 13:48:59 +0200
Subject: [PATCH 2/6] ARM: sun5i: chip: add a node for the w1 gpio controller
In-Reply-To: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a132bfdc6f4eae5540f1a3df4b68ba9bba9d0935.1476704881.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

The CHIP uses a 1-Wire bus to discover the DIPs. Enable the bus in the DT.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index e616084b9495..059d86865b73 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -81,6 +81,13 @@
 		pinctrl-0 = <&chip_wifi_reg_on_pin>;
 		reset-gpios = <&pio 2 19 GPIO_ACTIVE_LOW>; /* PC19 */
 	};
+
+	onewire {
+		compatible = "w1-gpio";
+		gpios = <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&chip_w1_pin>;
+	};
 };
 
 &be0 {
@@ -181,6 +188,13 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	chip_w1_pin: chip_w1_pin at 0 {
+		allwinner,pins = "PD2";
+		allwinner,function = "gpio_in";
+	        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+	        allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
 };
 
 &reg_dcdc2 {
-- 
git-series 0.8.10
