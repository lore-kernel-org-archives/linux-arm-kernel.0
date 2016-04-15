From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 15 Apr 2016 15:32:55 +0900
Subject: [PATCH v2 8/8] ARM: dts: Add support of Bus frequency using VDD_INT
 for exynos5422-odroidxu3
In-Reply-To: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1460701975-24178-9-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the bus device tree nodes for INT (Internal) block
to enable the AMBA bus frequency scaling and add the NoC (Network on Chip)
Probe Device Tree node to measure the bandwidht for AMBA AXI bus.

The WCORE bus bus is parent device in INT block using VDD_INT.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 1bd507bfa750..d32984c5ff93 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -56,6 +56,89 @@
 	};
 };
 
+&bus_wcore {
+	devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
+			<&nocp_mem1_0>, <&nocp_mem1_1>;
+	vdd-supply = <&buck3_reg>;
+	exynos,saturation-ratio = <100>;
+	status = "okay";
+};
+
+&bus_noc {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_fsys_apb {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_fsys {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_fsys2 {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_mfc {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_gen {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_peri {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_g2d {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_g2d_acp {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_jpeg {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_jpeg_apb {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_disp1_fimd {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_disp1 {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_gscl_scaler {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_mscl {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
 &clock_audss {
 	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
 			<&clock_audss EXYNOS_MOUT_I2S>,
@@ -361,6 +444,22 @@
 	cap-sd-highspeed;
 };
 
+&nocp_mem0_0 {
+	status = "okay";
+};
+
+&nocp_mem0_1 {
+	status = "okay";
+};
+
+&nocp_mem1_0 {
+	status = "okay";
+};
+
+&nocp_mem1_1 {
+	status = "okay";
+};
+
 &pinctrl_0 {
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
-- 
1.9.1
