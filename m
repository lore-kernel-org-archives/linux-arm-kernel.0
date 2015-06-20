From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Jun 2015 10:17:29 +0200
Subject: [PATCH v3 4/6] ARM: dts: pxa: add embedded pxa camera capture
 interface
In-Reply-To: <1434788251-11839-1-git-send-email-robert.jarzmik@free.fr>
References: <1434788251-11839-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1434788251-11839-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa27x SoCs have an embedded camera host controller. Add the
description to the family description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: Sergey's comment on ePAR standard: "imaging"
---
 arch/arm/boot/dts/pxa27x.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 506db86..1402e23 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -77,6 +77,23 @@
 			clocks = <&clks CLK_KEYPAD>;
 			status = "disabled";
 		};
+
+		pxa_camera: imaging at 50000000 {
+			compatible = "marvell,pxa270-qci";
+			reg = <0x50000000 0x1000>;
+			interrupts = <33>;
+			dmas = <&pdma 68 0	/* Y channel */
+				&pdma 69 0	/* U channel */
+				&pdma 70 0>;	/* V channel */
+			dma-names = "CI_Y", "CI_U", "CI_V";
+
+			clocks = <&clks CLK_CAMERA>;
+			clock-names = "ciclk";
+			clock-frequency = <5000000>;
+			clock-output-names = "qci_mclk";
+
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.1.4
