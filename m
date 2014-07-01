From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Tue,  1 Jul 2014 13:09:01 +0200
Subject: [PATCH v2 4/5] ARM: dts: imx6: edmqmx6: Add can bus
In-Reply-To: <cover.1404212584.git.silvio.fricke@gmail.com>
References: <cover.1404212584.git.silvio.fricke@gmail.com>
Message-ID: <20b4514aab4e17c45a002e14c661a86743078955.1404212584.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index dd9ef16..8c1cb53 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -95,6 +95,12 @@
 	};
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	status = "okay";
+};
+
 &ecspi5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi5>;
@@ -300,6 +306,13 @@
 			>;
 		};
 
+		pinctrl_can1: can1grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b0
+				MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x1b0b0
+			>;
+		};
+
 		pinctrl_ecspi5: ecspi5rp-1 {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_DAT0__ECSPI5_MISO	0x80000000
-- 
2.0.0
