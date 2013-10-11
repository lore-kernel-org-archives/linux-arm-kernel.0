From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Fri, 11 Oct 2013 16:48:16 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Add backlight support for lvds
Message-ID: <1381520896-18576-1-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for lvds backlight on boards
i.MX6q-SabreSD and i.MX6dl-SabreSD

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 64e454b..651cf39 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -80,6 +80,14 @@
 		mux-int-port = <2>;
 		mux-ext-port = <3>;
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		status = "okay";
+	};
 };
 
 &audmux {
@@ -202,6 +210,12 @@
 	};
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_1>;
+	status = "okay";
+};
+
 &ssi2 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
-- 
1.8.1.2
