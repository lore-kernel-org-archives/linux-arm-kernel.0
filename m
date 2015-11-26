From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Nov 2015 13:49:47 +0100
Subject: [PATCH v2 1/4] ARM: dts: exynos4210: MDMA1 device belongs to LCD0
 power domain
In-Reply-To: <1448542190-19498-1-git-send-email-m.szyprowski@samsung.com>
References: <1448542190-19498-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1448542190-19498-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos 4210 MDMA1 device belongs to LCD0 power domain, so add proper
power-domains property. On Exynos 4x12, it belongs to TOP power domain,
which is always enabled, thus require no assignment in exynos4x12.dtsi.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b7474cf2..aac0f17 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -271,6 +271,10 @@
 		     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
 };
 
+&mdma1 {
+	power-domains = <&pd_lcd0>;
+};
+
 &pmu_system_controller {
 	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
 			"clkout4", "clkout8", "clkout9";
-- 
1.9.2
