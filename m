From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  7 Nov 2013 12:45:05 +0400
Subject: [PATCH 2/5] ARM: dts: i.MX51: Update CPU node
In-Reply-To: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
References: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
Message-ID: <1383813908-26571-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates i.MX51 CPU node:
- Alias for CPU is added to allow using this node in the parent DTS files.
- Removed useless "clock_names" property.
- "clock-latency" value increased to safe using with 32 kHz OSC.
- Defined operating points voltages and "voltage tolerance" properties.
  Values are safe for both commercial and industrial CPU variants.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 1075a7d..20e07bf 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -65,18 +65,18 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu at 0 {
+		cpu: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0>;
-			clock-latency = <61036>; /* two CLK32 periods */
+			clock-latency = <62500>;
 			clocks = <&clks 24>;
-			clock-names = "cpu";
 			operating-points = <
-				/* kHz  uV (No regulator support) */
-				160000  0
-				800000  0
+				166000	1000000
+				600000	1050000
+				800000	1100000
 			>;
+			voltage-tolerance = <5>;
 		};
 	};
 
-- 
1.8.1.5
