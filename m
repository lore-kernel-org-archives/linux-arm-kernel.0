From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 21:50:26 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new irq controller
 compatibles
In-Reply-To: <1391806226-27480-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391806226-27480-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391806226-27480-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the device tree to the new compatibles introduced in the irqchip drivers
to have a common pattern accross all Allwinner SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 26cf191..f9d902f 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -347,7 +347,7 @@
 		};
 
 		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sun4i-ic";
+			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index b114be7..e65fbf26 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -308,7 +308,7 @@
 		};
 
 		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sun4i-ic";
+			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 5c121fc..d209179 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -290,7 +290,7 @@
 		ranges;
 
 		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sun4i-ic";
+			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
1.8.4.2
