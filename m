From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sun, 27 Apr 2014 02:08:44 +0530
Subject: [PATCH RFC 4/8] ARM: dts: Add PPMU device tree support for Exynos5420
In-Reply-To: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
References: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1398544728-2075-5-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PPMU is required by the exynos5420 devfreq driver. Add a device
tree node for it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 67ba2c5..5cda3df 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -732,4 +732,11 @@
 		clock-names = "secss";
 		samsung,power-domain = <&g2d_pd>;
 	};
+
+	ppmu {
+		compatible = "samsung,exynos5420-ppmu";
+		reg = <0x10D10000 0x2000	/* PPMU_DMC_0_1 */
+		       0x10D60000 0x2000	/* PPMU_DMC_1_0 */
+		       0x10D70000 0x2000>;	/* PPMU_DMC_1_1 */
+	};
 };
-- 
1.8.3.2
