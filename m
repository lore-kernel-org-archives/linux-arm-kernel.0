From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:09:09 -0600
Subject: [RFT/RFC/PATCH 22/31] arm: boot: dts: omap2/3/am33xx: drop ti,
 intc-size
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-23-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we are now infering number of IRQ lines based
on correct compatible flag, which renders this
binding completely useless.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 -
 arch/arm/boot/dts/omap2.dtsi  | 1 -
 arch/arm/boot/dts/omap3.dtsi  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 93dd479..63acc21 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -106,7 +106,6 @@
 			compatible = "ti,am33xx-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
-			ti,intc-size = <128>;
 			reg = <0x48200000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index a2bfcde..50f8aff 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -57,7 +57,6 @@
 			compatible = "ti,omap2-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
-			ti,intc-size = <96>;
 			reg = <0x480FE000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index e42d17d..6d9626a 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -92,7 +92,6 @@
 			compatible = "ti,omap3-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
-			ti,intc-size = <96>;
 			reg = <0x48200000 0x1000>;
 		};
 
-- 
1.8.4.GIT
