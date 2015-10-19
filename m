From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 19 Oct 2015 15:28:03 +0530
Subject: [PATCH] arm64: dts: Add reboot node for exynos7
Message-ID: <1445248683-28403-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add syscon-reboot node to reboot exynos7 based SoCs.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 4d132692996f..1bc8e15363e8 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -450,6 +450,13 @@
 			reg = <0x105c0000 0x5000>;
 		};
 
+		reboot: syscon-reboot {
+			compatible = "syscon-reboot";
+			regmap = <&pmu_system_controller>;
+			offset = <0x0400>;
+			mask = <0x1>;
+		};
+
 		rtc: rtc at 10590000 {
 			compatible = "samsung,s3c6410-rtc";
 			reg = <0x10590000 0x100>;
-- 
1.7.10.4
