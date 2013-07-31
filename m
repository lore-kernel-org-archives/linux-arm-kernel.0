From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 31 Jul 2013 16:37:53 +0200
Subject: [PATCH 3/10] ARM: dts: mxs: set dcp to "disabled" by default
In-Reply-To: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375281480-25775-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reintroduce 'status = "disabled"' for the dcp node that was dropped by
commit 519d8b1a "Added support for Freescale's DCP co-processor".

Explicitly enable it in imx28-evk which is referenced in the commit
message of that commit.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-evk.dts |    4 ++++
 arch/arm/boot/dts/imx28.dtsi    |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index e035f46..6556197 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -360,3 +360,7 @@
 		default-brightness-level = <6>;
 	};
 };
+
+&dcp {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index d077958..acfb8ac 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -734,6 +734,7 @@
 				compatible = "fsl-dcp";
 				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
+				status = "disabled";
 			};
 
 			pxp: pxp at 8002a000 {
-- 
1.7.2.5
