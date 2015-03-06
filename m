From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 6 Mar 2015 16:04:20 +0800
Subject: [PATCH 1/2] ARM: imx6qdl-sabresd: set swbst_reg as vbus's parent reg
Message-ID: <1425629061-8995-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB vbus 5V is from PMIC SWBST, so set swbst_reg as vbus's
parent reg, it fixed a bug that the voltage of vbus is incorrect
due to swbst_reg is disabled after boots up.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index f1cd214..a626e6d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -35,6 +35,7 @@
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio3 22 0>;
 			enable-active-high;
+			vin-supply = <&swbst_reg>;
 		};
 
 		reg_usb_h1_vbus: regulator at 1 {
@@ -45,6 +46,7 @@
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio1 29 0>;
 			enable-active-high;
+			vin-supply = <&swbst_reg>;
 		};
 
 		reg_audio: regulator at 2 {
-- 
1.9.1
