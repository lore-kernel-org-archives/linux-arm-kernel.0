From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 07 Mar 2018 18:27:10 +0100
Subject: [PATCH 3/4] ARM: dts: exynos5250-snow MAX98095 CODEC node update
In-Reply-To: <20180307172711.15697-1-s.nawrocki@samsung.com>
References: <20180307172711.15697-1-s.nawrocki@samsung.com>
 <CGME20180307172738epcas2p20b57ae0b00fc1a422cd3e9b1b297753c@epcas2p2.samsung.com>
Message-ID: <20180307172711.15697-3-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing clocks, clock-names properties so the CODEC can
properly handle its master clock. Without this change sound on exynos5250-snow
doesn't work.
Missing #sound-dai-cells property is also added so it is possible to specify
the DAI links properly for HDMI audio support.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
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
