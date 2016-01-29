From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 29 Jan 2016 16:39:01 +0800
Subject: [PATCH 1/6] arm64: dts: hip05: Add L2 cache topology
In-Reply-To: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1454056746-5048-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hip05 SoC has four L2 cache for all 16 CPUs, every four cpus
share one L2 cache, add them to the dtsi file so that the cache
hierarchy can be probed.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index c1ea999..db2039d 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -90,6 +90,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20000>;
 			enable-method = "psci";
+			next-level-cache = <&cluster0_l2>;
 		};
 
 		cpu1: cpu at 20001 {
@@ -97,6 +98,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20001>;
 			enable-method = "psci";
+			next-level-cache = <&cluster0_l2>;
 		};
 
 		cpu2: cpu at 20002 {
@@ -104,6 +106,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20002>;
 			enable-method = "psci";
+			next-level-cache = <&cluster0_l2>;
 		};
 
 		cpu3: cpu at 20003 {
@@ -111,6 +114,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20003>;
 			enable-method = "psci";
+			next-level-cache = <&cluster0_l2>;
 		};
 
 		cpu4: cpu at 20100 {
@@ -118,6 +122,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20100>;
 			enable-method = "psci";
+			next-level-cache = <&cluster1_l2>;
 		};
 
 		cpu5: cpu at 20101 {
@@ -125,6 +130,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20101>;
 			enable-method = "psci";
+			next-level-cache = <&cluster1_l2>;
 		};
 
 		cpu6: cpu at 20102 {
@@ -132,6 +138,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20102>;
 			enable-method = "psci";
+			next-level-cache = <&cluster1_l2>;
 		};
 
 		cpu7: cpu at 20103 {
@@ -139,6 +146,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20103>;
 			enable-method = "psci";
+			next-level-cache = <&cluster1_l2>;
 		};
 
 		cpu8: cpu at 20200 {
@@ -146,6 +154,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20200>;
 			enable-method = "psci";
+			next-level-cache = <&cluster2_l2>;
 		};
 
 		cpu9: cpu at 20201 {
@@ -153,6 +162,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20201>;
 			enable-method = "psci";
+			next-level-cache = <&cluster2_l2>;
 		};
 
 		cpu10: cpu at 20202 {
@@ -160,6 +170,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20202>;
 			enable-method = "psci";
+			next-level-cache = <&cluster2_l2>;
 		};
 
 		cpu11: cpu at 20203 {
@@ -167,6 +178,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20203>;
 			enable-method = "psci";
+			next-level-cache = <&cluster2_l2>;
 		};
 
 		cpu12: cpu at 20300 {
@@ -174,6 +186,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20300>;
 			enable-method = "psci";
+			next-level-cache = <&cluster3_l2>;
 		};
 
 		cpu13: cpu at 20301 {
@@ -181,6 +194,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20301>;
 			enable-method = "psci";
+			next-level-cache = <&cluster3_l2>;
 		};
 
 		cpu14: cpu at 20302 {
@@ -188,6 +202,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20302>;
 			enable-method = "psci";
+			next-level-cache = <&cluster3_l2>;
 		};
 
 		cpu15: cpu at 20303 {
@@ -195,6 +210,23 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x20303>;
 			enable-method = "psci";
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible = "cache";
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible = "cache";
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible = "cache";
 		};
 	};
 
-- 
2.6.0.GIT
