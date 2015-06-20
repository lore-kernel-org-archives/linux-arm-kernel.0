From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Jun 2015 10:17:28 +0200
Subject: [PATCH v3 3/6] ARM: dts: pxa: add dma pxamci nodes to pxa3xx
In-Reply-To: <1434788251-11839-1-git-send-email-robert.jarzmik@free.fr>
References: <1434788251-11839-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1434788251-11839-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 3 possible mmc controllers on pxa3xx SoCs to the devicetree
description. Add the dma and clocks to the device-tree description of
pxa27x and pxa3xx at the same time.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa2xx.dtsi |  4 ++++
 arch/arm/boot/dts/pxa3xx.dtsi | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 71a0cd7..5e5af07 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -128,6 +128,10 @@
 			compatible = "marvell,pxa-mmc";
 			reg = <0x41100000 0x1000>;
 			interrupts = <23>;
+			clocks = <&clks CLK_MMC>;
+			dmas = <&pdma 21 3
+				&pdma 22 3>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index d90489b..29aeac5 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -53,6 +53,39 @@
 			interrupt-controller;
 			#interrupt-cells = <0x2>;
 		};
+
+		mmc0: mmc at 41100000 {
+			compatible = "marvell,pxa-mmc";
+			reg = <0x41100000 0x1000>;
+			interrupts = <23>;
+			clocks = <&clks CLK_MMC>;
+			dmas = <&pdma 21 3
+				&pdma 22 3>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		mmc1: mmc at 42000000 {
+			compatible = "marvell,pxa-mmc";
+			reg = <0x42000000 0x1000>;
+			interrupts = <41>;
+			clocks = <&clks CLK_MMC1>;
+			dmas = <&pdma 93 3
+				&pdma 94 3>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		mmc2: mmc at 42500000 {
+			compatible = "marvell,pxa-mmc";
+			reg = <0x42500000 0x1000>;
+			interrupts = <55>;
+			clocks = <&clks CLK_MMC2>;
+			dmas = <&pdma 46 3
+				&pdma 47 3>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.1.4
