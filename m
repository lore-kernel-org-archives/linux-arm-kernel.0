From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Sep 2012 17:54:17 +0200
Subject: [PATCH v3 4/5] arm: mvebu: add DT information for GPIO banks on
 Armada 370 and XP
In-Reply-To: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347551658-24449-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpioX aliases are needed so that the driver can use
of_alias_get_id() to get a 0-based number of the GPIO bank, which we
then use to compute the base GPIO of the bank being probed. This is
similar to what gpio-mxs.c is doing.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi        |   36 +++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   27 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   39 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   39 ++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 2bfb904..af34cdb 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -21,6 +21,12 @@
 	model = "Marvell Armada 370 family SoC";
 	compatible = "marvell,armada370", "marvell,armada-370-xp";
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+	};
+
 	mpic: interrupt-controller at d0020000 {
 	      reg = <0xd0020a00 0x1d0>,
 		    <0xd0021870 0x58>;
@@ -35,6 +41,36 @@
 		pinctrl {
 			compatible = "marvell,mv88f6710-pinctrl";
 			reg = <0xd0018000 0x38>;
+	        };
+
+		gpio0: gpio at d0018100 {
+			compatible = "marvell,orion-gpio";
+			reg = <0xd0018100 0x40>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <82>, <83>, <84>, <85>;
+		};
+
+		gpio1: gpio at d0018140 {
+			compatible = "marvell,orion-gpio";
+			reg = <0xd0018140 0x40>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <87>, <88>, <89>, <90>;
+		};
+
+		gpio2: gpio at d0018180 {
+			compatible = "marvell,orion-gpio";
+			reg = <0xd0018180 0x40>;
+			ngpios = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <91>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 38ede3d..05a1f27 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -19,10 +19,37 @@
 	model = "Marvell Armada XP MV78230 SoC";
 	compatible = "marvell,armadaxp-mv78230", "marvell,armadaxp", "marvell,armada-370-xp";
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+	};
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78230-pinctrl";
 			reg = <0xd0018000 0x38>;
 		};
+
+		gpio0: gpio at d0018100 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018100 0x40>,
+			    <0xd0018800 0x30>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <16>, <17>, <18>, <19>;
+		};
+
+		gpio1: gpio at d0018140 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018140 0x40>,
+			    <0xd0018840 0x30>;
+			ngpios = <17>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <20>, <21>, <22>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index b2eafcd..fe28ff2 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -19,10 +19,49 @@
 	model = "Marvell Armada XP MV78260 SoC";
 	compatible = "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+	};
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78260-pinctrl";
 			reg = <0xd0018000 0x38>;
 		};
+
+		gpio0: gpio at d0018100 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018100 0x40>,
+			    <0xd0018800 0x30>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <16>, <17>, <18>, <19>;
+		};
+
+		gpio1: gpio at d0018140 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018140 0x40>,
+			    <0xd0018840 0x30>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <20>, <21>, <22>, <23>;
+		};
+
+		gpio2: gpio at d0018180 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018180 0x40>,
+			    <0xd0018870 0x30>;
+			ngpios = <3>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <24>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index cf8624d..e55b310 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -19,10 +19,49 @@
 	model = "Marvell Armada XP MV78460 SoC";
 	compatible = "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+	};
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78460-pinctrl";
 			reg = <0xd0018000 0x38>;
 		};
+
+		gpio0: gpio at d0018100 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018100 0x40>,
+			    <0xd0018800 0x30>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <16>, <17>, <18>, <19>;
+		};
+
+		gpio1: gpio at d0018140 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018140 0x40>,
+			    <0xd0018840 0x30>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <20>, <21>, <22>, <23>;
+		};
+
+		gpio2: gpio at d0018180 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018180 0x40>,
+			    <0xd0018870 0x30>;
+			ngpios = <3>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			interrupts = <24>;
+		};
 	};
  };
-- 
1.7.9.5
