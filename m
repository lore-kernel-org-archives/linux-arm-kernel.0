From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 24 Oct 2014 17:55:31 +0100
Subject: [PATCH 2/4] ARM: dts: hummingboard: add mSATA support for iMX6
 quad/dual HummingBoard
Message-ID: <E1Xhi9D-0005pL-HS@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabeeh Khoury <rabeeh@solid-run.com>
To: Shawn Guo <shawn.guo@linaro.org>

Initial patch from Rabeeh, but with the electrical properties added.

Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6q-hummingboard.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-hummingboard.dts b/arch/arm/boot/dts/imx6q-hummingboard.dts
index 0a3574105165..c2bf8476ce45 100644
--- a/arch/arm/boot/dts/imx6q-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6q-hummingboard.dts
@@ -11,3 +11,11 @@
 	model = "SolidRun HummingBoard Dual/Quad";
 	compatible = "solidrun,hummingboard/q", "fsl,imx6q";
 };
+
+&sata {
+	status = "okay";
+	fsl,transmit-level-mV = <1025>;
+	fsl,transmit-boost-mdB = <3330>;
+	fsl,transmit-atten-16ths = <9>;
+	fsl,receive-eq-mdB = <3000>;
+};
-- 
1.8.3.1
