From: eagle.alexander923@gmail.com (Alexander Shiyan)
Date: Sun, 23 Jun 2013 10:54:45 +0400
Subject: [PATCH 1/6] ARM: dts: imx27: Add SAHARA2 devicetree node
Message-ID: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shiyan <shc_work@mail.ru>

This patch adds the missing (Symmetric/Asymmetric Hashing and Random
Accelerator) SAHARA2 devicetree node for i.MX27 CPUs.

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 0695264..04f9154 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -351,6 +351,14 @@
 				iram = <&iram>;
 			};
 
+			sahara2: sahara at 10025000 {
+				compatible = "fsl,imx27-sahara";
+				reg = <0x10025000 0x0800>;
+				interrupts = <59>;
+				clocks = <&clks 32>, <&clks 64>;
+				clock-names = "ipg", "ahb";
+			};
+
 			clks: ccm at 10027000{
 				compatible = "fsl,imx27-ccm";
 				reg = <0x10027000 0x1000>;
-- 
1.8.1.5
