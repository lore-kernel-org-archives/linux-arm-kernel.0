From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 28 Oct 2015 10:57:36 +0300
Subject: [PATCH v3 2/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <cover.1446018918.git.p.fedin@samsung.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
Message-ID: <40d3e02ee082e994e155f662407552a96319e6b4.1446018918.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This machine uses own SoC device tree file, add missing part.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 4603356..e2b58f8 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -101,6 +101,11 @@
 			reg = <0x10000000 0x100>;
 		};
 
+		sromc: sromc at 12250000 {
+			compatible = "samsung,exynos-srom";
+			reg = <0x12250000 0x14>;
+		};
+
 		pmu_system_controller: system-controller at 10040000 {
 			compatible = "samsung,exynos5410-pmu", "syscon";
 			reg = <0x10040000 0x5000>;
-- 
2.4.4
