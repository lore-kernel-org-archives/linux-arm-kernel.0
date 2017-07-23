From: martin@kaiser.cx (Martin Kaiser)
Date: Sun, 23 Jul 2017 19:49:05 +0200
Subject: [PATCH v6 2/3] ARM: i.MX25: add RNGB node to dtsi
In-Reply-To: <1500832146-8660-1-git-send-email-martin@kaiser.cx>
References: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
 <1500832146-8660-1-git-send-email-martin@kaiser.cx>
Message-ID: <1500832146-8660-2-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Add a devicetree entry for the Random Number Generator Version B (RNGB).
The driver for RNGC supports version B as well.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
Changes in v6:
  - use rngb instead of just rng

Changes in v5:
  none

Changes in v4:
  none

Changes in v3:
  - remove clock-names from dtsi

Changes in v2:
  - remove interrupt-names from dtsi

 arch/arm/boot/dts/imx25.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index dfcc8e0..d8d3163 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -451,6 +451,13 @@
 				interrupt-names = "scm", "smn";
 			};
 
+			rngb: rngb at 53fb0000 {
+				compatible = "fsl,imx25-rngb";
+				reg = <0x53fb0000 0x4000>;
+				clocks = <&clks 109>;
+				interrupts = <22>;
+			};
+
 			esdhc1: esdhc at 53fb4000 {
 				compatible = "fsl,imx25-esdhc";
 				reg = <0x53fb4000 0x4000>;
-- 
2.1.4
