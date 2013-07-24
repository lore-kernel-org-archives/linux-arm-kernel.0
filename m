From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 24 Jul 2013 15:17:23 +0200
Subject: [PATCH v4 11/13] ARM: dts: Add FIMC nodes for Exynos4210 Trats board
In-Reply-To: <1374671845-30373-1-git-send-email-s.nawrocki@samsung.com>
References: <1374671845-30373-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1374671845-30373-12-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable FIMC devices on the Trats board. This allows using the
device in memory-to-memory mode only. The camera port pinctrl
property is now empty and will be updated while support for the
camera sensors is added.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 94eebff..199ff1e 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -301,4 +301,26 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	camera {
+		pinctrl-names = "default";
+		pinctrl-0 = <>;
+		status = "okay";
+
+		fimc_0: fimc at 11800000 {
+			status = "okay";
+		};
+
+		fimc_1: fimc at 11810000 {
+			status = "okay";
+		};
+
+		fimc_2: fimc at 11820000 {
+			status = "okay";
+		};
+
+		fimc_3: fimc at 11830000 {
+			status = "okay";
+		};
+	};
 };
-- 
1.7.9.5
