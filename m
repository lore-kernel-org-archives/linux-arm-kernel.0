From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 3 Jul 2015 09:29:13 +0800
Subject: [PATCH] dts: mt8173-oak: Add da9211 to i2c1
Message-ID: <1435886953-11258-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DA9211 dual-channel BUCK regulator to i2c1.
This regulator supplies GPU and DVFS1 voltages.

Change-Id: I61ecc64b29da4913be856f43e0f6f6fa4e58ea7e
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
This patch based on https://github.com/mbgg/linux-mediatek.git branch/v4.2-next/arm64
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index d0ab012..7f583bd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -34,6 +34,36 @@
 	chosen { };
 };
 
+&i2c1 {
+	status = "okay";
+
+	buck: da9211 at 68 {
+		compatible = "dlg,da9211";
+		reg = <0x68>;
+
+		regulators {
+			da9211_vcpu_reg: BUCKA {
+				regulator-name = "VBUCKA";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1310000>;
+				regulator-min-microamp	= <2000000>;
+				regulator-max-microamp	= <4400000>;
+				regulator-ramp-delay = <10000>;
+				regulator-always-on;
+			};
+
+			da9211_vgpu_reg: BUCKB {
+				regulator-name = "VBUCKB";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1310000>;
+				regulator-min-microamp	= <2000000>;
+				regulator-max-microamp	= <3000000>;
+				regulator-ramp-delay = <10000>;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
1.8.1.1.dirty
