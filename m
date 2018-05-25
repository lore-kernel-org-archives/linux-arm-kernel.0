From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 May 2018 16:01:50 +0530
Subject: [PATCH 04/15] arm: dts: rk322x: Add missing cooling device properties
 for CPUs
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Message-ID: <406021e33d541ca0318a6b15687084ca19fdd943.1527244201.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/rk322x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index be80e9a2c9af..ef414e39bf3a 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -80,6 +80,7 @@
 			reg = <0xf01>;
 			resets = <&cru SRST_CORE1>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 			enable-method = "psci";
 		};
 
@@ -89,6 +90,7 @@
 			reg = <0xf02>;
 			resets = <&cru SRST_CORE2>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 			enable-method = "psci";
 		};
 
@@ -98,6 +100,7 @@
 			reg = <0xf03>;
 			resets = <&cru SRST_CORE3>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 			enable-method = "psci";
 		};
 	};
-- 
2.15.0.194.g9af6a3dea062
