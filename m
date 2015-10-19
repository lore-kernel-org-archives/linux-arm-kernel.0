From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 14:00:33 +0900
Subject: [PATCH 2/3] ARM: dts: Add PRNG module for exynos4
In-Reply-To: <1445230834-32689-1-git-send-email-k.kozlowski@samsung.com>
References: <1445230834-32689-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1445230834-32689-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Pseudo Random Number Generator (PRNG) node of Security Sub System
(SSS) to Exynos 4 DTSI.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 3184e10f260a..a6b9913ea2b5 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -954,4 +954,12 @@
 		power-domains = <&pd_lcd0>;
 		#iommu-cells = <0>;
 	};
+
+	prng: rng at 10830400 {
+		compatible = "samsung,exynos4-rng";
+		reg = <0x10830400 0x200>;
+		clocks = <&clock CLK_SSS>;
+		clock-names = "secss";
+		status = "disabled";
+	};
 };
-- 
1.9.1
