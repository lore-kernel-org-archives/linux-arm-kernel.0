From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 17 Sep 2015 12:15:03 +0200
Subject: [PATCH v3 4/6] ARM: berlin: dts: add the cpufreq-dt bindings on the
 BG2
In-Reply-To: <1442484905-15656-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1442484905-15656-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1442484905-15656-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2 uses cpugreq-dt. Add the corresponding bindings.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index ef811de09908..d80dc82729b8 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -57,6 +57,16 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <0>;
+
+			clocks = <&chip_clk CLKID_CPU>;
+			clock-latency = <100000>;
+			operating-points = <
+				/* kHz    uV */
+				1200000 1200000
+				1000000 1200000
+				800000  1200000
+				600000  1200000
+			>;
 		};
 
 		cpu at 1 {
-- 
2.5.2
