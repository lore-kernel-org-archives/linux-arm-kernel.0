From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Apr 2018 19:46:02 +0200
Subject: [PATCH 5/5] ARM: dts: exynos: Remove unnecessary address/size
 properties in dp-controller of Exynos5
In-Reply-To: <20180424174602.3915-1-krzk@kernel.org>
References: <20180424174602.3915-1-krzk@kernel.org>
Message-ID: <20180424174602.3915-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "dp-controller" node is not a bus and it does not have children with
reg/ranges properties so remove address-cells and size-cells properties.
This fixes warnings for all Exynos5 boards:

    arch/arm/boot/dts/exynos5250-arndale.dtb: Warning (avoid_unnecessary_addr_size):
        /soc/dp-controller at 145b0000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 359f49bdd4e2..5d2f0a06fbef 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -196,8 +196,6 @@
 			reg = <0x145B0000 0x1000>;
 			interrupts = <10 3>;
 			interrupt-parent = <&combiner>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.14.1
