From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 8 Oct 2013 20:56:17 +0200
Subject: [PATCH v3 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <20131008181647.GW5402@titan.lakedaemon.net>
References: <20131008194232.7d74b9e6@armhf> <525448DE.5030004@gmail.com>
 <20131008181647.GW5402@titan.lakedaemon.net>
Message-ID: <20131008205617.079142b6@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch activates the audio device of the Cubox.

The audio flow (pin mpp_audio1) is output on both I2S and S/PDIF.

The third si5351 clock (#2, pin mpp13) is used as the external clock.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
Jason,

this patch replaces the previous patch v2 2/2

v3:
- move the pins declaration to dove.dtsi (Sebastian Hesselbarth)
---
 arch/arm/boot/dts/dove.dtsi      | 10 ++++++++++
 arch/arm/boot/dts/dove-cubox.dts |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index e177e66..772b15e 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -227,6 +227,11 @@
 				marvell,function = "gpio";
 			};
 
+			pmx_audio1_extclk: pmx-audio1-extclk {
+				marvell,pins = "mpp13";
+				marvell,function = "audio1";
+			};
+
 			pmx_gpio_14: pmx-gpio-14 {
 				marvell,pins = "mpp14";
 				marvell,function = "gpio";
@@ -302,6 +307,11 @@
 				marvell,function = "gpio";
 			};
 
+			pmx_audio1_i2s1_spdifo: pmx-audio1-i2s1-spdifo {
+				marvell,pins = "mpp_audio1";
+				marvell,function = "i2s1/spdifo";
+			};
+
 			pmx_spi0: pmx-spi0 {
 				marvell,pins = "mpp_spi0";
 				marvell,function = "spi0";
diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 022646e..78b0057 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -132,3 +132,11 @@
 		reg = <0>;
 	};
 };
+
+&audio1 {
+	status = "okay";
+	clocks = <&gate_clk 13>, <&si5351 2>;
+	clock-names = "internal", "extclk";
+	pinctrl-0 = <&pmx_audio1_i2s1_spdifo &pmx_audio1_extclk>;
+	pinctrl-names = "default";
+};

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
