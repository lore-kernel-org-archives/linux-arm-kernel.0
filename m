From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 Mar 2018 18:22:47 +0100
Subject: [PATCH v3 3/6] ARM: dts: exynos: Update of the max98095 node in
 exynos5250-snow.dts
In-Reply-To: <20180309172250.23019-1-s.nawrocki@samsung.com>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172414epcas1p36b0c39ad993afcad7f8cf8941cc6bf68@epcas1p3.samsung.com>
Message-ID: <20180309172250.23019-3-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing clocks, clock-names properties so the CODEC can
properly handle its master clock. Without this change sound on exynos5250-snow
doesn't work.
Missing #sound-dai-cells property is also added so it is possible to specify
the DAI links properly for HDMI audio support.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - edited commit summary line.
---
 arch/arm/boot/dts/exynos5250-snow.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 4827cb506fa3..16e37c337a3f 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -27,6 +27,9 @@
 		reg = <0x11>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98095_en>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
+		#sound-dai-cells = <1>;
 	};
 };
 
-- 
2.14.2
