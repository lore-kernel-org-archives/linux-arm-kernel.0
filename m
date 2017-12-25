From: andy.tang@nxp.com (Yuantian Tang)
Date: Mon, 25 Dec 2017 15:57:23 +0800
Subject: [PATCH] arm64: dts: ls208xa: add power monitor chip node
Message-ID: <20171225075723.31080-1-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ina220 chip was used on ls208xardb platform to monitor power
comsumption. So add ina220 chip node in dts to enable power
consumption monitor feature.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 9a1d0d2..a75132c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -95,6 +95,17 @@
 			};
 		};
 
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x02>;
+			ina220 at 40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <500>;
+			};
+		};
+
 		i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.1
