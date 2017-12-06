From: stefan@agner.ch (Stefan Agner)
Date: Wed,  6 Dec 2017 11:29:29 +0100
Subject: [PATCH] ARM: dts: colibri/apalis: use correct compatible for RTC
Message-ID: <20171206102929.4755-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Toradex Carrier Boards use a st,m41t0 compatible RTC. Compared
to a st,m41t00 this RTC has also an oscillator fail bit which allows
to detect when the RTC lost track of time.

Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 2 +-
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 2 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi   | 2 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 5705ebee0595..dcf9206f3e0d 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -163,7 +163,7 @@
 
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc at 68 {
-		compatible = "st,m41t00";
+		compatible = "st,m41t0";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 8b56656e53da..aa0e631f3c0a 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -158,7 +158,7 @@
 
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc at 68 {
-		compatible = "st,m41t00";
+		compatible = "st,m41t0";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 27dc0fc686a9..e8dccf552122 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -170,7 +170,7 @@
 
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc at 68 {
-		compatible = "st,m41t00";
+		compatible = "st,m41t0";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 40b2c67fe7af..6831dfd24cc1 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -174,7 +174,7 @@
 
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc at 68 {
-		compatible = "st,m41t00";
+		compatible = "st,m41t0";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 3d6c282dd258..3cf9b077d4f3 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -133,7 +133,7 @@
 
 	/* M41T0M6 real time clock on carrier board */
 	rtc: m41t0m6 at 68 {
-		compatible = "st,m41t00";
+		compatible = "st,m41t0";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 091b738041a0..d8b2972527eb 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -140,7 +140,7 @@
 
 	/* M41T0M6 real time clock on carrier board */
 	rtc: m41t0m6 at 68 {
-		compatible = "st,m41t00";
+		compatible = "st,m41t0";
 		reg = <0x68>;
 	};
 };
-- 
2.15.1
