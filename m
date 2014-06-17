From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 11:06:35 +0200
Subject: [PATCH 7/7] ARM: dts: imx6*, remove ssi fsl,mode for sgtl5000 cards
In-Reply-To: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
References: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1402995995-15098-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DAI mode is and should be configured by the sound card driver as
codec and ssi have to be in the right modes to communicate with each
other. It is possible to operate the ssi unit or the codec in master mode,
sometimes even on the same board in different configurations.

With the latest changes in the fsl-ssi driver, the 'fsl,mode' property
is only handled as a fallback property. If the sound card sets the DAI
mode correctly, this fallback configuration is dropped.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-riotboard.dts    | 1 -
 arch/arm/boot/dts/imx6q-gw5400-a.dts      | 1 -
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi     | 1 -
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi     | 1 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi     | 1 -
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 1 -
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi    | 1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi  | 1 -
 9 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 909fafc0b650..80c926894d1e 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -254,7 +254,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 3689eaa58826..c5de2b768b63 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -504,7 +504,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 367af3ec9435..00b515c46929 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -489,7 +489,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index c91b5a6c769b..39554077e28e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -533,7 +533,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 3245ae85f12b..50ff650a5d11 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -555,7 +555,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 4c4b17596c8b..42ff525ebe13 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -381,7 +381,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 6df6127bf835..0a36129152e0 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -381,7 +381,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 40ea36534643..3e1eb5ed4aef 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -512,7 +512,6 @@
 };
 
 &ssi2 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 5c6f10c43f65..13eae9e5bae8 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -233,7 +233,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
-- 
2.0.0
