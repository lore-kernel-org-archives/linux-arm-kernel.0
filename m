From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:45:02 +0800
Subject: [PATCH 06/11] ARM: dts: imx28-evk: add missing properties for fec
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing properties for fec, phy-supply, phy-reset-gpios and
phy-reset-duration, which are required by fec driver for successfully
probe fec from device tree, if bootloader hasn't set those things up.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 28b94d3..cf2ab2e 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -120,6 +120,9 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
+			phy-supply = <&reg_fec_3v3>;
+			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-duration = <100>;
 			status = "okay";
 		};
 
@@ -149,6 +152,14 @@
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio3 28 0>;
 		};
+
+		reg_fec_3v3: fec-3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "fec-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 15 0>;
+		};
 	};
 
 	sound {
-- 
1.7.5.4
