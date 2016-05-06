From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 May 2016 09:27:16 +0200
Subject: [PATCH v6 9/9] ARM: dts: exynos: Add interrupt line to MAX8997 PMIC on
 exynos4210-trats
In-Reply-To: <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462519636-3250-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

MAX8997 PMIC requires interrupt and fails probing without it.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: d105f0b1215d ("ARM: dts: Add basic dts file for Samsung Trats board")
Cc: <stable@vger.kernel.org>
[k.kozlowski: Write commit message, add CC-stable]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index fed5847410d3..79d983036560 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -298,6 +298,8 @@
 		compatible = "maxim,max8997-pmic";
 
 		reg = <0x66>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <7 0>;
 
 		max8997,pmic-buck1-uses-gpio-dvs;
 		max8997,pmic-buck2-uses-gpio-dvs;
-- 
1.9.1
