From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 21 Mar 2014 12:43:38 +0100
Subject: [PATCH 3/5] ARM: berlin/dt: add cpupll and syspll support to BG2Q
In-Reply-To: <1395402220-23503-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395402220-23503-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1395402220-23503-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 07452a7483fa..19d2c82b0664 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -59,10 +59,26 @@
 		clock-frequency = <100000000>;
 	};
 
+	syspll: syspll {
+		compatible = "marvell,berlin2q-pll";
+		clocks = <&smclk>;
+		#clock-cells = <0>;
+		reg = <0xf7ea0030 8>;
+	};
+
+	cpupll: cpupll {
+		compatible = "marvell,berlin2q-pll";
+		clocks = <&smclk>;
+		#clock-cells = <0>;
+		reg = <0xf7dd0170 8>;
+	};
+
 	cpuclk: cpu-clock {
-		compatible = "fixed-clock";
+		compatible = "fixed-factor-clock";
+		clocks = <&cpupll>;
 		#clock-cells = <0>;
-		clock-frequency = <1200000000>;
+		clock-div = <1>;
+		clock-mult = <1>;
 	};
 
 	twdclk: twdclk {
-- 
1.8.3.2
