From: chanho61.park@samsung.com (Chanho Park)
Date: Tue, 13 Aug 2013 14:12:57 +0900
Subject: [PATCHv3 2/4] ARM: dts: Add rotator node for exynos4210
In-Reply-To: <1376370779-26930-1-git-send-email-chanho61.park@samsung.com>
References: <1376370779-26930-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1376370779-26930-3-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a rotator node for exynos4210. The exynos4210 has different
limitation of image size compared with later chips.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 597cfcf..baa3e56 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -243,6 +243,14 @@
 		status = "disabled";
 	};
 
+	rotator at 12810000 {
+		compatible = "samsung,exynos4210-rotator";
+		reg = <0x12810000 0x1000>;
+		interrupts = <0 83 0>;
+		clocks = <&clock 278>;
+		clock-names = "rotator";
+	};
+
 	mfc: codec at 13400000 {
 		compatible = "samsung,mfc-v5";
 		reg = <0x13400000 0x10000>;
-- 
1.7.9.5
