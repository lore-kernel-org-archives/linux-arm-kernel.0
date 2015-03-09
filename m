From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  9 Mar 2015 17:40:34 +0100
Subject: [PATCH 1/3] ARM: dts: imx6dl-aristainetos: enable backlight PWM
 explicitly
In-Reply-To: <1425919236-6664-1-git-send-email-p.zabel@pengutronix.de>
References: <1425919236-6664-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1425919236-6664-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All PWM users should explicitly enable the used PWMs in their device tree
so they can be disabled by default in imx6qdl.dtsi.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts | 4 ++++
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index 9cd06e5..d4c4a22 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -83,3 +83,7 @@
 &ipu1_di0_disp0 {
 	remote-endpoint = <&display0_in>;
 };
+
+&pwm1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
index b413e24..15203f0 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -72,3 +72,7 @@
 &ipu1_di0_disp0 {
 	remote-endpoint = <&display0_in>;
 };
+
+&pwm3 {
+	status = "okay";
+};
-- 
2.1.4
