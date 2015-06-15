From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 15 Jun 2015 12:23:21 +0930
Subject: [PATCHv7 2/4] ARM: dts: exynos5422-odroidxu3: Enable TMU at
 Exynos5422 base
In-Reply-To: <1434336803-4132-1-git-send-email-linux.amoon@gmail.com>
References: <1434336803-4132-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1434336803-4132-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes enables TMU IP block on the Exynos5422 Odroid-XU3
device.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes rebase on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung branch for-next
Changes from v5 and v6: Use LDO7 regulator instead of LDO10 regulator to control TMU.
	Fixed the commit log.
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 17e6a9a..96d894e 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -474,6 +474,31 @@
 	status = "okay";
 };
 
+&tmu_cpu0 {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
+&tmu_cpu1 {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
+&tmu_cpu2 {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
+&tmu_cpu3 {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
+&tmu_gpu {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
-- 
2.4.3
