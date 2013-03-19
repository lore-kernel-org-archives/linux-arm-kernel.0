From: achew@nvidia.com (Andrew Chew)
Date: Tue, 19 Mar 2013 11:59:30 -0700
Subject: [PATCH V4 6/9] ARM: mxs: Provide regulator to pwm-backlight
In-Reply-To: <1363719573-20926-1-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
Message-ID: <1363719573-20926-7-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
 arch/arm/boot/dts/imx23-evk.dts      | 6 ++++++
 arch/arm/boot/dts/imx28-apf28dev.dts | 6 ++++++
 arch/arm/boot/dts/imx28-cfa10049.dts | 6 ++++++
 arch/arm/boot/dts/imx28-evk.dts      | 6 ++++++
 arch/arm/boot/dts/imx28-tx28.dts     | 6 ++++++
 5 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 035c13f..e48e36c 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -97,10 +97,16 @@
 		};
 	};
 
+	bl_en: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-en-supply";
+        };
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 2 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		enable-supply = <&bl_en>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 6d8865b..866e26f 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -144,11 +144,17 @@
 		};
 	};
 
+	bl_en: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-en-supply";
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 
 		pwms = <&pwm 3 191000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		enable-supply = <&bl_en>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index a0d3e9f..a8477b6 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -299,10 +299,16 @@
 		rotary-encoder,relative-axis;
 	};
 
+	bl_en: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-en-supply";
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 3 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		enable-supply = <&bl_en>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 2da316e..810f1e4 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -307,10 +307,16 @@
 		};
 	};
 
+	bl_en: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-en-supply";
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 2 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		enable-supply = <&bl_en>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 37be532..ea3c88a 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -107,10 +107,16 @@
 		};
 	};
 
+	bl_en: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl-en-supply";
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		enable-supply = <&bl_en>;
 	};
 };
-- 
1.8.1.5
