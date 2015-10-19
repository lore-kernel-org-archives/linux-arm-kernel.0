From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 19 Oct 2015 17:16:43 +0530
Subject: [PATCH v4 5/8] ARM: dts: add SROM device node for exynos5
In-Reply-To: <1445255206-11148-1-git-send-email-pankaj.dubey@samsung.com>
References: <1445255206-11148-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1445255206-11148-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SROM controller device node for exynos5.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 110dbd4..b5d3437 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -30,6 +30,11 @@
 		reg = <0x10000000 0x100>;
 	};
 
+	sromc at 12250000 {
+		compatible = "samsung,exynos-srom";
+		reg = <0x12250000 0x10>;
+	};
+
 	combiner: interrupt-controller at 10440000 {
 		compatible = "samsung,exynos4210-combiner";
 		#interrupt-cells = <2>;
-- 
2.4.5
