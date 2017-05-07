From: ayaka@soulik.info (Randy Li)
Date: Sun,  7 May 2017 22:26:27 +0800
Subject: [PATCH] ARM: dts: rockchip: add adc button for Firefly
Message-ID: <20170507142627.5307-1-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only adc button connected to adc input is recovery button.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 17 +++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi       | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index d0b3204a..ed1baa8 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -48,6 +48,19 @@
 	model = "Firefly-RK3288-reload";
 	compatible = "firefly,firefly-rk3288-reload", "rockchip,rk3288";
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_BACK>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -246,6 +259,10 @@
 	status = "okay";
 };
 
+&saradc {
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 10793ac..63b8b2d 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -49,6 +49,19 @@
 		reg = <0 0x80000000>;
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_BACK>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
 	dovdd_1v8: dovdd-1v8-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "dovdd_1v8";
-- 
2.9.3
