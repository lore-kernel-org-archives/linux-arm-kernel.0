From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 21 Aug 2014 18:52:35 +0545
Subject: [PATCH v2 1/3] ARM: dts: Add pmu node for exynos5800 SoC
In-Reply-To: <1408626457-3422-1-git-send-email-vikas.sajjan@samsung.com>
References: <1408626457-3422-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1408626457-3422-2-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds pmu node for exynos5800 SoC.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 arch/arm/boot/dts/exynos5800.dtsi                  |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index 1e1979b..9647317 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -10,6 +10,7 @@ Properties:
 		   - "samsung,exynos5260-pmu" - for Exynos5260 SoC.
 		   - "samsung,exynos5410-pmu" - for Exynos5410 SoC,
 		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
+		   - "samsung,exynos5800-pmu" - for Exynos5800 SoC.
 		second value must be always "syscon".
 
  - reg : offset and length of the register set.
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..2009b9c 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -26,3 +26,7 @@
 &mfc {
 	compatible = "samsung,mfc-v8";
 };
+
+&pmu_system_controller {
+	compatible = "samsung,exynos5800-pmu", "syscon";
+};
-- 
1.7.9.5
