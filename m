From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 11:06:34 +0200
Subject: [PATCH 6/7] ARM: dts: imx5*, remove ssi fsl,mode for sgtl5000 cards
In-Reply-To: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
References: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1402995995-15098-7-git-send-email-mpa@pengutronix.de>
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
 arch/arm/boot/dts/imx51-babbage.dts     | 1 -
 arch/arm/boot/dts/imx53-m53evk.dts      | 1 -
 arch/arm/boot/dts/imx53-mba53.dts       | 1 -
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 1 -
 arch/arm/boot/dts/imx53-tx53.dtsi       | 1 -
 arch/arm/boot/dts/imx53-voipac-bsb.dts  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 6bc3243a80d3..3b3ad3419c67 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -392,7 +392,6 @@
 };
 
 &ssi2 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index d5d146a8b149..3569acbc9339 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -429,7 +429,6 @@
 };
 
 &ssi2 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 3e3f17aa93a1..2e44d2aba14e 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -225,7 +225,6 @@
 };
 
 &ssi2 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index fd8c60dde7de..181ae5ebf23f 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -141,7 +141,6 @@
 };
 
 &ssi2 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index e348796ba689..704bd72cbfec 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -502,7 +502,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	codec-handle = <&sgtl5000>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-voipac-bsb.dts b/arch/arm/boot/dts/imx53-voipac-bsb.dts
index 7f6711a48615..c17d3ad6dba5 100644
--- a/arch/arm/boot/dts/imx53-voipac-bsb.dts
+++ b/arch/arm/boot/dts/imx53-voipac-bsb.dts
@@ -154,6 +154,5 @@
 };
 
 &ssi2 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
-- 
2.0.0
