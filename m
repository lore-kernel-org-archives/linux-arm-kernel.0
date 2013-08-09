From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 09 Aug 2013 16:40:52 +0900
Subject: [PATCHv2 4/5] ARM: dts: Add rotator node for exynos5250
In-Reply-To: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
References: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1376034053-31910-5-git-send-email-chanho61.park@samsung.com>
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
 arch/arm/boot/dts/exynos5250.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 6f356ce..7ee2da8 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -570,6 +570,15 @@
 		};
 	};
 
+	rotator: rotator at 11C00000 {
+		compatible = "samsung,exynos5250-rotator";
+		reg = <0x11C00000 0x1000>;
+		interrupts = <0 84 0>;
+		clocks = <&clock 269>;
+		clock-names = "rotator";
+		status = "disabled";
+	};
+
 	gsc_0:  gsc at 0x13e00000 {
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e00000 0x1000>;
-- 
1.7.9.5
