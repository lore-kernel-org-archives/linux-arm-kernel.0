From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 8 Oct 2013 19:42:32 +0200
Subject: [PATCH v2 2/2] ARM: Dove: Add the audio device to the Cubox DT
Message-ID: <20131008194232.7d74b9e6@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch activates the audio device of the Cubox.

The audio flow (pin mpp_audio1) is output on both I2S and S/PDIF.

The third si5351 clock (#2, pin mpp13) is used as the external clock.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/dove-cubox.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 022646e..bb38a24 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -132,3 +132,23 @@
 		reg = <0>;
 	};
 };
+
+&pinctrl {
+	pmx_gpio_13_audio1: pmx-gpio-13-audio1 {
+		marvell,pins = "mpp13";
+		marvell,function = "audio1";
+	};
+
+	pmx_audio1_i2s1_spdifo: pmx-audio1-i2s1-spdifo {
+		marvell,pins = "mpp_audio1";
+		marvell,function = "i2s1/spdifo";
+	};
+};
+
+&audio1 {
+	status = "okay";
+	clocks = <&gate_clk 13>, <&si5351 2>;
+	clock-names = "internal", "extclk";
+	pinctrl-0 = <&pmx_audio1_i2s1_spdifo &pmx_gpio_13_audio1>;
+	pinctrl-names = "default";
+};

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
