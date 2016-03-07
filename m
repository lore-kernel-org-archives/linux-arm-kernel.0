From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  7 Mar 2016 13:00:04 +0100
Subject: [PATCH v3 2/3] ARM: i.MX25: add scc module to dtsi
In-Reply-To: <1457352005-17457-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1457352005-17457-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1457352005-17457-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Security Controller (SCC) module to the dtsi.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index cde329e9b9e3..73118aba4cc4 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -397,6 +397,15 @@
 				interrupts = <41>;
 			};
 
+			scc: crypto at 53fac000 {
+				compatible = "fsl,imx25-scc";
+				reg = <0x53fac000 0x4000>;
+				clocks = <&clks 111>;
+				clock-names = "ipg";
+				interrupts = <49>, <50>;
+				interrupt-names = "scm", "smn";
+			};
+
 			esdhc1: esdhc at 53fb4000 {
 				compatible = "fsl,imx25-esdhc";
 				reg = <0x53fb4000 0x4000>;
-- 
2.7.0
