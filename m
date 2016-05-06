From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 May 2016 09:27:15 +0200
Subject: [PATCH v6 8/9] ARM: dts: exynos: Fix regulator name to avoid forbidden
 character on exynos4210-trats
In-Reply-To: <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462519636-3250-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

The usage of slash character causes failure when creating regulator
debugfs entry.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
[k.kozlowski: Write commit message]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 1df2f0bc1d76..fed5847410d3 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -359,7 +359,7 @@
 			};
 
 			vusbdac_reg: LDO8 {
-			     regulator-name = "VUSB/VDAC_3.3V_C210";
+			     regulator-name = "VUSB+VDAC_3.3V_C210";
 			     regulator-min-microvolt = <3300000>;
 			     regulator-max-microvolt = <3300000>;
 			};
-- 
1.9.1
