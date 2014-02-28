From: cosminstefan.stoica@freescale.com (Stoica Cosmin Stefan)
Date: Fri, 28 Feb 2014 14:46:51 +0200
Subject: [PATCH] arm: dts: vf610-twr: Add support for sdhc1
Message-ID: <1393591611-3147-1-git-send-email-cosminstefan.stoica@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cosmin Stoica <cosminstefan.stoica@freescale.com>

The kernel was not able to boot from SD card because sdhc support
was not present into the dts.

A new entry for sdhc1 was added for vf610-twr board based on the
compatible entry present on imx53.

After applying these changes, the kernel is able to boot successfully
from SD card.

Signed-off-by: Cosmin Stoica <cosminstefan.stoica@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts |    7 +++++++
 arch/arm/boot/dts/vf610.dtsi    |   10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 7dd1d6e..fa4cf48 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -227,3 +227,10 @@
 	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
+
+&esdhc1 {
+   pinctrl-names = "default";
+   pinctrl-0 = <&pinctrl_esdhc1_1>;
+   bus-width = <4>;
+   status = "okay";
+};
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index c63d26d..516b6d2 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -344,6 +344,16 @@
 				status = "disabled";
 			};
 
+			esdhc1: esdhc at 400b2000 {
+				   compatible = "fsl,imx53-esdhc";
+				   reg = <0x400b2000 0x4000>;
+				   interrupts = <0 28 0x04>;
+				   clocks = <&clks VF610_CLK_IPG_BUS>, <&clks VF610_CLK_PLATFORM_BUS>, <&clks VF610_CLK_ESDHC1>;
+				   clock-names = "ipg", "ahb", "per";
+				   bus-width = <4>;
+				   status = "disabled";
+			};
+
 			fec0: ethernet at 400d0000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d0000 0x1000>;
-- 
1.7.9.5
