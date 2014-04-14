From: chanho61.park@samsung.com (Chanho Park)
Date: Mon, 14 Apr 2014 21:48:17 +0900
Subject: [PATCH 1/4] ARM: dts: exynos4: add PMU syscon node
In-Reply-To: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
References: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1397479700-15864-2-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a PMU(Power Management Unit) syscon node. This
should be required for USB Phy syscon regmap I/F.

Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kamil Debski <k.debski@samsung.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 2f8bcd0..e565b86 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -110,6 +110,11 @@
 		reg = <0x10010000 0x400>;
 	};
 
+	pmu_reg: syscon at 10020000 {
+		compatible = "samsung,exynos4-pmureg", "syscon";
+		reg = <0x10020000 0x4000>;
+	};
+
 	dsi_0: dsi at 11C80000 {
 		compatible = "samsung,exynos4210-mipi-dsi";
 		reg = <0x11C80000 0x10000>;
-- 
1.8.3.2
