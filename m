From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 27 Oct 2015 11:43:52 +0300
Subject: [PATCH v2 1/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <cover.1445935215.git.p.fedin@samsung.com>
References: <cover.1445935215.git.p.fedin@samsung.com>
Message-ID: <91ae80f172192fa4dbc8bf8ee5a9068661592de6.1445935215.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This machine uses own SoC device tree file, add missing part.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 4603356..af85aad 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -101,6 +101,11 @@
 			reg = <0x10000000 0x100>;
 		};
 
+		sromc: sromc at 12250000 {
+			compatible = "samsung,exynos-srom";
+			reg = <0x12250000 0x10>;
+		};
+
 		pmu_system_controller: system-controller at 10040000 {
 			compatible = "samsung,exynos5410-pmu", "syscon";
 			reg = <0x10040000 0x5000>;
-- 
2.4.4
