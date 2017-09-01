From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 01 Sep 2017 10:47:54 +0900
Subject: [PATCH 1/3] ARM: dts: exynos: Add the hardware rotation limits for gsc
In-Reply-To: <1504230476-1878-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1504230476-1878-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170901014757epcas2p2093964b6b7e5dff4c197bf7ec2c306a8@epcas2p2.samsung.com>
Message-ID: <1504230476-1878-2-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gscaler has maximum size of input or output rotation. Add the
hardware limits property for the gscaler rotation in the exynos5250
and exynos5420 dts.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 8 ++++++++
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 8dbeb87..d9434e0 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -643,6 +643,8 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL0>;
 			clock-names = "gscl";
+			rot-max-hsize = <2048>;
+			rot-max-vsize = <2048>;
 			iommu = <&sysmmu_gsc0>;
 		};
 
@@ -653,6 +655,8 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL1>;
 			clock-names = "gscl";
+			rot-max-hsize = <2048>;
+			rot-max-vsize = <2048>;
 			iommu = <&sysmmu_gsc1>;
 		};
 
@@ -663,6 +667,8 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL2>;
 			clock-names = "gscl";
+			rot-max-hsize = <2048>;
+			rot-max-vsize = <2048>;
 			iommu = <&sysmmu_gsc2>;
 		};
 
@@ -673,6 +679,8 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL3>;
 			clock-names = "gscl";
+			rot-max-hsize = <2048>;
+			rot-max-vsize = <2048>;
 			iommu = <&sysmmu_gsc3>;
 		};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 02d2f89..0fd6be9 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -664,6 +664,8 @@
 			clocks = <&clock CLK_GSCL0>;
 			clock-names = "gscl";
 			power-domains = <&gsc_pd>;
+			rot-max-hsize = <2016>;
+			rot-max-vsize = <2016>;
 			iommus = <&sysmmu_gscl0>;
 		};
 
@@ -674,6 +676,8 @@
 			clocks = <&clock CLK_GSCL1>;
 			clock-names = "gscl";
 			power-domains = <&gsc_pd>;
+			rot-max-hsize = <2016>;
+			rot-max-vsize = <2016>;
 			iommus = <&sysmmu_gscl1>;
 		};
 
-- 
1.9.1
