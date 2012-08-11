From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 11 Aug 2012 15:31:45 +0200
Subject: [PATCH 4/5] arm: mvebu: add DT information for GPIO banks on Armada
 370 and XP
In-Reply-To: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1344691906-15985-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi        |   30 +++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   22 ++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   33 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   33 ++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 875fcd8..b0c832c 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -35,5 +35,35 @@
                 pinctrl at d0018000 {
 			        compatible = "marvell,mv88f6710-pinctrl";
 	        };
+
+		gpio0: gpio at d0018100 {
+			compatible = "marvell,orion-gpio";
+			reg = <0xd0018100 0x40>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <1>;
+			interrupt-controller;
+			interrupts = <82>, <83>, <84>, <85>;
+		};
+
+		gpio1: gpio at d0018140 {
+			compatible = "marvell,orion-gpio";
+			reg = <0xd0018140 0x40>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <1>;
+			interrupt-controller;
+			interrupts = <87>, <88>, <89>, <90>;
+		};
+
+		gpio2: gpio at d0018180 {
+			compatible = "marvell,orion-gpio";
+			reg = <0xd0018180 0x40>;
+			ngpios = <2>;
+			gpio-controller;
+			#gpio-cells = <1>;
+			interrupt-controller;
+			interrupts = <91>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 69ad287..081f3f7 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -23,5 +23,27 @@
 		pinctrl at d0018000 {
 			compatible = "marvell,mv78230-pinctrl";
 		};
+
+		gpio0: gpio at d0018100 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018100 0x40>,
+			    <0xd0018800 0x30>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <1>;
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
+			#gpio-cells = <1>;
+			interrupt-controller;
+			interrupts = <20>, <21>, <22>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 0f38fa9..fa791fa 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -23,5 +23,38 @@
 		pinctrl at d0018000 {
 			compatible = "marvell,mv78260-pinctrl";
 		};
+
+		gpio0: gpio at d0018100 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018100 0x40>,
+			    <0xd0018800 0x30>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <1>;
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
+			#gpio-cells = <1>;
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
+			#gpio-cells = <1>;
+			interrupt-controller;
+			interrupts = <24>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 9e61836..a372d13 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -23,5 +23,38 @@
 		pinctrl at d0018000 {
 			compatible = "marvell,mv78460-pinctrl";
 		};
+
+		gpio0: gpio at d0018100 {
+			compatible = "marvell,armadaxp-gpio";
+			reg = <0xd0018100 0x40>,
+			    <0xd0018800 0x30>;
+			ngpios = <32>;
+			gpio-controller;
+			#gpio-cells = <1>;
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
+			#gpio-cells = <1>;
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
+			#gpio-cells = <1>;
+			interrupt-controller;
+			interrupts = <24>;
+		};
 	};
  };
-- 
1.7.9.5
