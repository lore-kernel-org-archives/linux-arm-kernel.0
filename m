From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 28 Jul 2014 17:45:25 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Add PMU DT node for exynos5260 SoC
In-Reply-To: <1406549726-10452-1-git-send-email-vikas.sajjan@samsung.com>
References: <1406549726-10452-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1406549726-10452-2-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addd PMU DT node for exynos5260 SoC.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 arch/arm/boot/dts/exynos5260.dtsi                  |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 2a4ab04..c038628 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -8,6 +8,7 @@ Properties:
 		   - "samsung,exynos4412-pmu" - for Exynos4412 SoC,
 		   - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
 		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
+		   - "samsung,exynos5260-pmu" - for Exynos5260 SoC.
 		second value must be always "syscon".
 
  - reg : offset and length of the register set.
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 5398a60..4f2fabe 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -227,6 +227,11 @@
 			interrupts = <0 243 0>;
 		};
 
+		pmu_system_controller: system-controller at 10D50000 {
+			compatible = "samsung,exynos5260-pmu", "syscon";
+			reg = <0x10D50000 0x10000>;
+		};
+
 		uart0: serial at 12C00000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C00000 0x100>;
-- 
1.7.9.5
