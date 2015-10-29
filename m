From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 15:42:18 +0300
Subject: [PATCH v4 2/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <cover.1446122247.git.p.fedin@samsung.com>
References: <cover.1446122247.git.p.fedin@samsung.com>
Message-ID: <eafa355058ff500a72ff2e3408ab635954467a76.1446122247.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This machine uses own SoC device tree file, add missing part.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 4603356..da6a8fa0e 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -101,6 +101,15 @@
 			reg = <0x10000000 0x100>;
 		};
 
+		sromc: sromc at 12250000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			compatible = "samsung,exynos-srom";
+			reg = <0x12250000 0x14>;
+		};
+
 		pmu_system_controller: system-controller at 10040000 {
 			compatible = "samsung,exynos5410-pmu", "syscon";
 			reg = <0x10040000 0x5000>;
@@ -133,6 +142,12 @@
 						<10 &gic 0 130 0>,
 						<11 &gic 0 131 0>;
 			};
+
+			arch_timer {
+				compatible = "arm,armv7-timer";
+				clock-frequency = <24000000>;
+			};
+
 		};
 
 		sysram at 02020000 {
-- 
2.4.4
