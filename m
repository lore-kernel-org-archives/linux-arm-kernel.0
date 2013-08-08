From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 15:30:27 +0200
Subject: [PATCH 1/3] ARM: dts: mxs: set dcp to "disabled" by default
In-Reply-To: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
References: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375968629-10091-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reintroduce 'status = "disabled"' for the dcp node that was dropped by
commit 519d8b1a "Added support for Freescale's DCP co-processor".

Explicitly enable it in imx28-evk which is referenced in the commit
message of that commit.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-evk.dts |    4 ++++
 arch/arm/boot/dts/imx28.dtsi    |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index dff2279..ac790bb 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -361,3 +361,7 @@
 		default-brightness-level = <6>;
 	};
 };
+
+&dcp {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e459d63..ea99d09 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -794,9 +794,10 @@
 			};
 
 			dcp: dcp at 80028000 {
+				compatible = "fsl-dcp";
 				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
-				compatible = "fsl-dcp";
+				status = "disabled";
 			};
 
 			pxp: pxp at 8002a000 {
-- 
1.7.2.5
