From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 10 Aug 2017 10:26:08 +0800
Subject: [PATCH v2 2/9] arm64: dts: hi3660: add L2 cache topology
In-Reply-To: <20170810022615.19204-1-guodong.xu@linaro.org>
References: <20170810022615.19204-1-guodong.xu@linaro.org>
Message-ID: <20170810022615.19204-3-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

This patch adds the L2 cache topology on 96boards Hikey960.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 8921310..1cdd03b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -58,6 +58,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
@@ -66,6 +67,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
@@ -74,6 +76,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
@@ -82,6 +85,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
@@ -90,6 +94,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <
 					&CPU_NAP
 					&CPU_SLEEP
@@ -102,6 +107,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <
 					&CPU_NAP
 					&CPU_SLEEP
@@ -114,6 +120,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <
 					&CPU_NAP
 					&CPU_SLEEP
@@ -126,6 +133,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <
 					&CPU_NAP
 					&CPU_SLEEP
@@ -171,6 +179,14 @@
 				min-residency-us = <20000>;
 			};
 		};
+
+		A53_L2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		A73_L2: l2-cache1 {
+			compatible = "cache";
+		};
 	};
 
 	gic: interrupt-controller at e82b0000 {
-- 
2.10.2
