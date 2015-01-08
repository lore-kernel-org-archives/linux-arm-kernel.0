From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  8 Jan 2015 15:39:41 +0100
Subject: [PATCH v3 5/7] ARM: mvebu: A38x: Remove redundant pinctrl informations
In-Reply-To: <1420727983-23922-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1420727983-23922-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1420727983-23922-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible set in the armada-38x DTSI is always overridden, and the reg
defined in there is duplicated in the armada-380 and armada-385 DTSIs.

Remove these useless items.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-380.dtsi | 1 -
 arch/arm/boot/dts/armada-385.dtsi | 1 -
 arch/arm/boot/dts/armada-38x.dtsi | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index 13400ce88c54..7e509d2d74d0 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -34,7 +34,6 @@
 		internal-regs {
 			pinctrl at 18000 {
 				compatible = "marvell,mv88f6810-pinctrl";
-				reg = <0x18000 0x20>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 5249a4d3c207..a54a252ddb4c 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -39,7 +39,6 @@
 		internal-regs {
 			pinctrl at 18000 {
 				compatible = "marvell,mv88f6820-pinctrl";
-				reg = <0x18000 0x20>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index ada1f206028b..40200084c6c8 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -194,7 +194,6 @@
 			};
 
 			pinctrl at 18000 {
-				compatible = "marvell,mv88f6820-pinctrl";
 				reg = <0x18000 0x20>;
 			};
 
-- 
2.2.1
