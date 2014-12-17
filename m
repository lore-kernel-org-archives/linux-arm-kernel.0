From: tony.kn@samsung.com (Tony K Nadackal)
Date: Wed, 17 Dec 2014 13:07:03 +0530
Subject: [PATCH] arm64: dts: Add device node for mscl on exynos7
Message-ID: <1418801823-16607-1-git-send-email-tony.kn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device node for mscl on exynos7 SoC.

Signed-off-by: Tony K Nadackal <tony.kn@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index f67319a..332537c 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -185,6 +185,12 @@
 				      "dout_sclk_mmc0", "dout_sclk_mmc1";
 		};
 
+		clock_mscl: clock-controller at 150d0000 {
+			compatible = "samsung,exynos7-clock-mscl";
+			reg = <0x150d0000 0xd00>;
+			#clock-cells = <1>;
+		};
+
 		serial_0: serial at 13630000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13630000 0x100>;
-- 
2.2.0
