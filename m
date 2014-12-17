From: tony.kn@samsung.com (Tony K Nadackal)
Date: Wed, 17 Dec 2014 13:09:36 +0530
Subject: [PATCH] arm64: dts: Add jpeg device node for Exynos7
Message-ID: <1418801976-22820-1-git-send-email-tony.kn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add jpeg device node for Exynos7

Signed-off-by: Tony K Nadackal <tony.kn@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 332537c..db3561f 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -562,6 +562,15 @@
 			clocks = <&clock_peric0 PCLK_PWM>;
 			clock-names = "timers";
 		};
+
+		jpeg: jpeg_codec at 15020000 {
+			compatible = "samsung,exynos7-jpeg";
+			reg = <0x15020000 0x1000>;
+			interrupts = <0 434 0>;
+			clocks = <&clock_mscl ACLK_JPEG>;
+			clock-names = "jpeg";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.2.0
