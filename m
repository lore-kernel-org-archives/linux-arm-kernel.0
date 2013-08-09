From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 09 Aug 2013 16:40:51 +0900
Subject: [PATCHv2 3/5] ARM: dts: Add rotator node for exynos4x12
In-Reply-To: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
References: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1376034053-31910-4-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a rotator node for exynos4212 and 4412. These have different
limitation of image size compared with the exynos4210. So, we should define
new compatible to distinguish it from the exynos4210.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 954628c..7bae33f 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -176,4 +176,8 @@
 			};
 		};
 	};
+
+	rotator: rotator at 12810000 {
+		compatible = "samsung,exynos4212-rotator";
+	};
 };
-- 
1.7.9.5
