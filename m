From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Wed,  5 Sep 2018 05:22:07 +0900
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77995-draak: Add MSIOF ch2 pins
 support
Message-ID: <1536092527-5950-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>

This patch adds support for MSIOF ch2 pinctrl to use the LVDS Control
Connector (CN41) for the Draak board on the R8A77995 SoC.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[ykaneko0929 at gmail.com: deleted the unused reference to 'msiof_ref_clk']
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index a8e8f26..e60b1e4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -135,6 +135,12 @@
 		function = "i2c1";
 	};
 
+	msiof2_pins: spi2 {
+		groups = "msiof2_clk", "msiof2_sync_b",
+			 "msiof2_rxd",  "msiof2_txd";
+		function = "msiof2";
+	};
+
 	pwm0_pins: pwm0 {
 		groups = "pwm0_c";
 		function = "pwm0";
@@ -371,3 +377,10 @@
 		};
 	};
 };
+
+&msiof2 {
+	pinctrl-0 = <&msiof2_pins>;
+	pinctrl-names = "default";
+	/* In case of using this node, please enable this property */
+	/* status = "okay"; */
+};
-- 
1.9.1
