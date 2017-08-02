From: martin@kaiser.cx (Martin Kaiser)
Date: Wed,  2 Aug 2017 22:06:11 +0200
Subject: [PATCH] ARM: dts: i.MX25: add ranges to tscadc
Message-ID: <1501704371-28151-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a ranges; line to the tscadc node. This creates a 1:1 mapping between
the addresses used by tscadc and those in its child nodes (adc, tsc).

Without such a mapping, the reg = ... lines in the tsc and adc nodes do
not create a resource. Probing the fsl-imx25-tcq and fsl-imx25-tsadc
drivers will then fail since there's no IORESOURCE_MEM.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx25.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 0d2f3a1..1e37bd3 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -297,6 +297,7 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				status = "disabled";
+				ranges;
 
 				adc: adc at 50030800 {
 					compatible = "fsl,imx25-gcq";
-- 
2.1.4
