From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Oct 2012 09:13:22 +0100
Subject: [PATCH 09/10] ARM: ux500: Add all bu21013 touch screen components to
 supported Device Trees
In-Reply-To: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349165603-24401-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible to connect a BU21013 Touch Screen to all version
of the HREF which support the ST-UIB. This patch applies all the
necessary settings to the pre-v60 and v60+ HREF Device Trees.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefprev60.dts  |    6 ++++++
 arch/arm/boot/dts/hrefv60plus.dts |    8 ++++++++
 arch/arm/boot/dts/stuib.dtsi      |   23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/hrefprev60.dts b/arch/arm/boot/dts/hrefprev60.dts
index e112cce..cd9e535 100644
--- a/arch/arm/boot/dts/hrefprev60.dts
+++ b/arch/arm/boot/dts/hrefprev60.dts
@@ -31,5 +31,11 @@
 				reg = <0x33>;
 			};
 		};
+
+		i2c at 80110000 {
+			bu21013_tp at 0x5c {
+				reset-gpio = <&tc3589x_gpio 13 0x4>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index b5fc355..82103a2 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -23,4 +23,12 @@
 			gpios = <&gpio6 25 0x4>;
 		};
 	};
+
+	soc-u9500 {
+		i2c at 80110000 {
+			bu21013_tp at 0x5c {
+				reset-gpio = <&gpio4 15 0x4>;
+			};
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/stuib.dtsi b/arch/arm/boot/dts/stuib.dtsi
index 64ac327..5547f38 100644
--- a/arch/arm/boot/dts/stuib.dtsi
+++ b/arch/arm/boot/dts/stuib.dtsi
@@ -11,5 +11,28 @@
 
 / {
 	soc-u9500 {
+		i2c at 80110000 {
+			bu21013_tp at 0x5c {
+				compatible = "bu21013_tp";
+				reg = <0x5c>;
+				touch-gpio = <&gpio2 20 0x4>;
+				avdd-supply = <&ab8500_ldo_aux1_reg>;
+
+				stericsson,touch-max-x = <384>;
+				stericsson,touch-max-y = <704>;
+				stricsson,flip-y;
+			};
+
+			bu21013_tp at 0x5d {
+				compatible = "bu21013_tp";
+				reg = <0x5d>;
+				touch-gpio = <&gpio2 20 0x4>;
+				avdd-supply = <&ab8500_ldo_aux1_reg>;
+
+				stericsson,touch-max-x = <384>;
+				stericsson,touch-max-y = <704>;
+				stricsson,flip-y;
+			};
+		};
 	};
 };
-- 
1.7.9.5
