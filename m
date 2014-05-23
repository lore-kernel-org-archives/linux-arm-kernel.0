From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 23 May 2014 16:39:20 +0200
Subject: [PATCH] ARM: dts: exynos4: Fix reg sizes of GIC
Message-ID: <1400855960-22033-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes reg entry sizes in GIC node that were not large enough
to cover whole regions.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8ece4b..fbaf426 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -113,7 +113,7 @@
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
+		reg = <0x10490000 0x10000>, <0x10480000 0x10000>;
 	};
 
 	combiner: interrupt-controller at 10440000 {
-- 
1.9.3
