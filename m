From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Mar 2016 11:08:14 +0900
Subject: [PATCH v2 6/7] ARM: dts: Add MSHC2 dt node for SD card for
 exynos3250-artik5-eval board
In-Reply-To: <1458007695-3627-1-git-send-email-cw00.choi@samsung.com>
References: <1458007695-3627-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1458007695-3627-7-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaehoon Chung <jh80.chung@samsung.com>

This patch adds MSHC (Mobile Storage Host Controller) dt node for
Exynos3250 SoC. MSHC is an interface between the system and the SD card

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250-artik5-eval.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
index b476154590a5..be4d6aa379f3 100644
--- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
+++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
@@ -21,6 +21,23 @@
 			"samsung,exynos3250", "samsung,exynos3";
 };
 
+&mshc_2 {
+	num-slots = <1>;
+	cap-sd-highspeed;
+	disable-wp;
+	vqmmc-supply = <&ldo3_reg>;
+	card-detect-delay = <200>;
+	clock-frequency = <100000000>;
+	clock-freq-min-max = <400000 100000000>;
+	samsung,dw-mshc-ciu-div = <1>;
+	samsung,dw-mshc-sdr-timing = <0 1>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd2_cmd &sd2_clk &sd2_cd &sd2_bus1 &sd2_bus4>;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &serial_2 {
 	status = "okay";
 };
-- 
1.9.1
