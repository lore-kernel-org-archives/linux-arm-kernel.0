From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 28 Aug 2013 11:35:21 +0200
Subject: [PATCH 2/2] ARM: Dove: Add the audio device to the Cubox DT
Message-ID: <20130828113521.35c53365@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch activates the audio device of the Cubox and sets the i2s
and S/PDIF pins.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/dove-cubox.dts                  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 4af59b6..003d95b 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -132,3 +132,16 @@
 		reg = <0>;
 	};
 };
+
+&pinctrl {
+	pmx_audio1_i2s1_spdifo: pmx-audio1-i2s1-spdifo {
+		marvell,pins = "mpp_audio1";
+		marvell,function = "i2s1/spdifo";
+	};
+};
+
+&i2s1 {
+	status = "okay";
+	pinctrl-0 = <&pmx_audio1_i2s1_spdifo>;
+	pinctrl-names = "default";
+};


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
