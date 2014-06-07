From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  7 Jun 2014 16:34:18 +0400
Subject: [PATCH] ARM: dts: i.MX35: Add GPT node
Message-ID: <1402144458-32328-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing (General Purpose Timer) GPT devicetree node
for i.MX35 CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx35.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 4759abb..442e216 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -193,6 +193,14 @@
 				#clock-cells = <1>;
 			};
 
+			gpt: timer at 53f90000 {
+				compatible = "fsl,imx35-gpt", "fsl,imx31-gpt";
+				reg = <0x53f90000 0x4000>;
+				interrupts = <29>;
+				clocks = <&clks 9>, <&clks 50>;
+				clock-names = "ipg", "per";
+			};
+
 			gpio3: gpio at 53fa4000 {
 				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
 				reg = <0x53fa4000 0x4000>;
-- 
1.8.5.5
