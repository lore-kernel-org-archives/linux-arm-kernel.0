From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 13 Jul 2013 08:34:44 +0400
Subject: [PATCH] ARM: dts: imx27: Add core voltages
Message-ID: <1373690084-26760-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds core voltages for i.MX27 CPUs. Only 266 and 400 MHz modes
is documented in the datasheet, so we add a 266 MHz frequency for conform this.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 056e33b..56b8c97 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -57,13 +57,14 @@
 			device_type = "cpu";
 			compatible = "arm,arm926ej-s";
 			operating-points = <
-				/* kHz  uV (No regulator support) */
-				133000  0
-				399000  0
+				/* kHz uV */
+				266000 1300000
+				399000 1450000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks 18>;
 			clock-names = "cpu";
+			voltage-tolerance = <5>;
 		};
 	};
 
-- 
1.8.1.5
