From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 27 Nov 2013 15:55:46 +0400
Subject: [PATCH 2/2] ARM: dts: imx51-babbage: Define FEC reset pin
In-Reply-To: <1385553346-20642-1-git-send-email-shc_work@mail.ru>
References: <1385553346-20642-1-git-send-email-shc_work@mail.ru>
Message-ID: <1385553346-20642-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index ee0deb3..483178a 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -299,7 +299,10 @@
 		};
 
 		pinctrl_fec: fecgrp {
-			fsl,pins = <MX51_FEC_PINGRP1>;
+			fsl,pins = <
+				MX51_FEC_PINGRP1
+				MX51_PAD_EIM_A20__GPIO2_14 0x85 /* Reset */
+			>;
 		};
 
 		pinctrl_i2c2: i2c2grp {
@@ -377,6 +380,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "mii";
+	phy-reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <1>;
 	status = "okay";
 };
 
-- 
1.8.3.2
