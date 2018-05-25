From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 May 2018 11:10:01 +0530
Subject: [PATCH 1/6] arm64: dts: amlogic: Add missing cooling device
 properties for CPUs
In-Reply-To: <cover.1527225682.git.viresh.kumar@linaro.org>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
Message-ID: <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
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
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 0868da476e41..313f88f8759e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -209,10 +209,34 @@
 	#cooling-cells = <2>;
 };
 
+&cpu1 {
+	#cooling-cells = <2>;
+};
+
+&cpu2 {
+	#cooling-cells = <2>;
+};
+
+&cpu3 {
+	#cooling-cells = <2>;
+};
+
 &cpu4 {
 	#cooling-cells = <2>;
 };
 
+&cpu5 {
+	#cooling-cells = <2>;
+};
+
+&cpu6 {
+	#cooling-cells = <2>;
+};
+
+&cpu7 {
+	#cooling-cells = <2>;
+};
+
 &ethmac {
 	pinctrl-0 = <&eth_pins>;
 	pinctrl-names = "default";
-- 
2.15.0.194.g9af6a3dea062
