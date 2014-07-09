From: fkan@apm.com (Feng Kan)
Date: Tue,  8 Jul 2014 19:15:51 -0700
Subject: [PATCH V8 4/6] arm64: dts: Add X-Gene reboot driver dts node
In-Reply-To: <1404872153-3594-1-git-send-email-fkan@apm.com>
References: <1404872153-3594-1-git-send-email-fkan@apm.com>
Message-ID: <1404872153-3594-5-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add X-Gene platform reboot driver dts node.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 40aa96c..876952c 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -103,6 +103,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		scu: system-clk-controller at 17000000 {
+			compatible = "apm,xgene-scu","syscon";
+			reg = <0x0 0x17000000 0x0 0x400>;
+		};
+
 		clocks {
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -397,5 +402,12 @@
 			#clock-cells = <1>;
 			clocks = <&rtcclk 0>;
 		};
+
+		reboot: reboot at 17000014 {
+			compatible = "syscon-reboot";
+			regmap = <&scu>;
+			offset = <0x14>;
+			mask = <0x1>;
+		};
 	};
 };
-- 
1.9.1
