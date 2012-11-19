From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:46:35 +0100
Subject: [PATCH 3/4] ARM: dts: exynos4210-origen: Update sdhci nodes for
 current bindings
In-Reply-To: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
References: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353336396-21161-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies sdhci nodes present in Origen device tree source
to use current generic mmc bindings.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 2eb1332..5395875 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -33,18 +33,14 @@
 	};
 
 	sdhci at 12530000 {
-		samsung,sdhci-bus-width = <4>;
-		linux,mmc_cap_4_bit_data;
-		samsung,sdhci-cd-internal;
+		bus-width = <4>;
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
 		pinctrl-names = "default";
 		status = "okay";
 	};
 
 	sdhci at 12510000 {
-		samsung,sdhci-bus-width = <4>;
-		linux,mmc_cap_4_bit_data;
-		samsung,sdhci-cd-internal;
+		bus-width = <4>;
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
 		pinctrl-names = "default";
 		status = "okay";
-- 
1.8.0
