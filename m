From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Wed, 09 Jan 2013 18:24:39 +0530
Subject: [PATCH 1/3] ARM: dts: exynos5: Add power domain clocks to pd node of
 Gscaler and MFC
In-Reply-To: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
References: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <1357736081-19390-2-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Power domain clks are added to Gscaler and MFC pd nodes.
These clocks are saved during power off.

Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 6d0e87c..8043be3 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -558,11 +558,13 @@
 	pd_gsc: gsc-power-domain at 0x10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
+		samsung,exynos-pd-clks ="aclk_266_gscl","aclk_300_gscl";
 	};
 
 	pd_mfc: mfc-power-domain at 0x10044040 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044040 0x20>;
+		samsung,exynos-pd-clks ="aclk_333";
 	};
 
 	gsc_0:  gsc at 0x13e00000 {
-- 
1.7.5.4
