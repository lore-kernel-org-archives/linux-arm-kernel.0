From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  6 Jun 2015 23:09:11 +0200
Subject: [PATCH 4/6] ARM: dts; pxa: add embedded pxa camera capture interface
In-Reply-To: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
References: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1433624953-28165-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa27x SoCs have an embedded camera host controller. Add the
description to the family description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 506db86..9ebfd7f 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -77,6 +77,23 @@
 			clocks = <&clks CLK_KEYPAD>;
 			status = "disabled";
 		};
+
+		pxa_camera: pxa_camera at 50000000 {
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
