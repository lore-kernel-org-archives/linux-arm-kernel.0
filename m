From: chanho61.park@samsung.com (Chanho Park)
Date: Tue, 13 Aug 2013 14:12:59 +0900
Subject: [PATCHv3 4/4] ARM: dts: Add rotator node for exynos5250
In-Reply-To: <1376370779-26930-1-git-send-email-chanho61.park@samsung.com>
References: <1376370779-26930-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1376370779-26930-5-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a rotator node for exynos5250. It has different align value of
image size compared with any other chips. So, we should define new compatible
for the exynos5250.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 6f356ce..f579546 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -570,6 +570,14 @@
 		};
 	};
 
+	rotator at 11C00000 {
+		compatible = "samsung,exynos5250-rotator";
+		reg = <0x11C00000 0x1000>;
+		interrupts = <0 84 0>;
+		clocks = <&clock 269>;
+		clock-names = "rotator";
+	};
+
 	gsc_0:  gsc at 0x13e00000 {
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e00000 0x1000>;
-- 
1.7.9.5
