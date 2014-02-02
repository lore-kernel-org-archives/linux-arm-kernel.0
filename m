From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:41:48 +0100
Subject: [PATCH 2/2] ARM: sunxi: dt: Convert to the new irq controller
 compatibles
In-Reply-To: <1391348508-9908-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391348508-9908-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391348508-9908-2-git-send-email-maxime.ripard@free-electrons.com>
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
index 040bb0e..725d47e 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -331,7 +331,7 @@
 		};
 
 		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sun4i-ic";
+			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index ea16054..c61f668 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -294,7 +294,7 @@
 		};
 
 		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sun4i-ic";
+			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 320335a..751b801 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -275,7 +275,7 @@
 		ranges;
 
 		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sun4i-ic";
+			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
1.8.4.2
