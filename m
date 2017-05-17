From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 17 May 2017 13:43:01 -0300
Subject: [PATCH 2/2] ARM: dts: tx6: Remove 'enable-active-low' property
In-Reply-To: <1495039381-23126-1-git-send-email-fabio.estevam@nxp.com>
References: <1495039381-23126-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1495039381-23126-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Property 'enable-active-low' does not exist. Only 'enable-active-high' is
valid, and when this property is absent the gpio regulator will act as
active low by default.

So remove the unexisting 'enable-active-low' property. 

While at it in order to make the gpio regulator description clearer pass
the GPIO_ACTIVE_LOW flag.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi  | 3 +--
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 1691714..a146fe7 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -133,8 +133,7 @@
 		regulator-max-microvolt = <3300000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flexcan_xcvr>;
-		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
-		enable-active-low;
+		gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	};
 
 	reg_lcd0_pwr: regulator-lcd0-pwr {
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index c784a0b..4ccc9e9 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -173,8 +173,7 @@
 		regulator-max-microvolt = <3300000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flexcan_xcvr>;
-		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
-		enable-active-low;
+		gpio = <&gpio3 5 GPIO_ACTIVE_LOW>;
 	};
 
 	reg_lcd_pwr: regulator-lcdpwr {
-- 
2.7.4
