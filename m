From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 6 Mar 2015 16:04:21 +0800
Subject: [PATCH 2/2] ARM: imx6sl-evk: set swbst_reg as vbus's parent reg
In-Reply-To: <1425629061-8995-1-git-send-email-peter.chen@freescale.com>
References: <1425629061-8995-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1425629061-8995-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB vbus 5V is from PMIC SWBST, so set swbst_reg as vbus's
parent reg, it fixed a bug that the voltage of vbus is incorrect
due to swbst_reg is disabled after boots up.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index fda4932..945887d 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -52,6 +52,7 @@
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio4 0 0>;
 			enable-active-high;
+			vin-supply = <&swbst_reg>;
 		};
 
 		reg_usb_otg2_vbus: regulator at 1 {
@@ -62,6 +63,7 @@
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio4 2 0>;
 			enable-active-high;
+			vin-supply = <&swbst_reg>;
 		};
 
 		reg_aud3v: regulator at 2 {
-- 
1.9.1
