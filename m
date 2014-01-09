From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  9 Jan 2014 13:01:10 +0800
Subject: [PATCH 3/4] ARM: dts: sirf: add clock,
 frequence-voltage table for CPU0
In-Reply-To: <1389243671-18099-1-git-send-email-21cnbao@gmail.com>
References: <1389243671-18099-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1389243671-18099-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

prima2 and atlas6 uses cpufreq_cpu0, here we put related clock, operation
points in dtsi.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    9 +++++++++
 arch/arm/boot/dts/prima2.dtsi |    9 +++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 0f1821a..2b5d678 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -27,6 +27,15 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			clocks = <&clks 12>;
+			operating-points = <
+				/* kHz    uV */
+				200000  1025000
+				400000  1025000
+				600000  1050000
+				800000  1100000
+			>;
+			clock-latency = <150000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 8cea924..0942f9a 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -29,6 +29,15 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
+			clocks = <&clks 12>;
+			operating-points = <
+				/* kHz    uV */
+				200000  1025000
+				400000  1025000
+				664000  1050000
+				800000  1100000
+			>;
+			clock-latency = <150000>;
 		};
 	};
 
-- 
1.7.5.4
