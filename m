From: martin@kaiser.cx (Martin Kaiser)
Date: Thu, 20 Jul 2017 22:27:26 +0200
Subject: [PATCH v5 2/3] ARM: i.MX25: add RNGC node to dtsi
In-Reply-To: <1500582447-28607-1-git-send-email-martin@kaiser.cx>
References: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
 <1500582447-28607-1-git-send-email-martin@kaiser.cx>
Message-ID: <1500582447-28607-2-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Add a devicetree entry for the Random Number Generator Version C (RNGC).

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
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
index dfcc8e0..0d2f3a1 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -451,6 +451,13 @@
 				interrupt-names = "scm", "smn";
 			};
 
+			rng: rng at 53fb0000 {
+				compatible = "fsl,imx25-rng";
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
