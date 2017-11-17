From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 17 Nov 2017 16:02:36 +0800
Subject: [PATCH 5/5] ARM64: dts: meson-axg: enable I2C Master-1 for the audio
 speaker
In-Reply-To: <20171117080236.32504-1-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
Message-ID: <20171117080236.32504-6-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jian Hu <jian.hu@amlogic.com>

In the S400 board, The I2C master-1 is connecting to
the audio speaker daughter board.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 7b39a9fe2b0f..74730e40f992 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -28,3 +28,9 @@
 	pinctrl-0 = <&eth_rgmii_y_pins>;
 	pinctrl-names = "default";
 };
+
+&i2c_m1 {
+	status = "okay";
+	pinctrl-0 = <&i2c_m1_z_pins>;
+	pinctrl-names = "default";
+};
-- 
2.14.1
