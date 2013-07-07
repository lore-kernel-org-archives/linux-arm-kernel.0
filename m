From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  7 Jul 2013 18:51:02 +0400
Subject: [RFC] ARM: dts: imx27: Add core voltages
Message-ID: <1373208662-7350-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds core voltages for i.MX27 CPUs. Only 266 and 400 MHz modes
is documented in the datasheet, we add a 266 MHz frequency for conform this.
For 133 MHz CPU frequency minimal voltage is used (1.2V).

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index a587294..c9bacca 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -57,13 +57,15 @@
 			device_type = "cpu";
 			compatible = "arm,arm926ej-s";
 			operating-points = <
-				/* kHz  uV (No regulator support) */
-				133000  0
-				399000  0
+				/* kHz uV */
+				133000 1200000
+				266000 1300000
+				399000 1450000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks 18>;
 			clock-names = "cpu";
+			voltage-tolerance = <1>;
 		};
 	};
 
-- 
1.8.1.5
