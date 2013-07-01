From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 01 Jul 2013 17:22:32 +0200
Subject: [PATCH v3 10/13] ARM: dts: Add FIMC nodes for Exynos4210 Trats board
In-Reply-To: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
References: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1372692155-17653-11-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable FIMC devices on the Trats board. This allows using the
device in memory-to-memory mode only. The camera port pinctrl
property is now empty and will be updated while support for the
camera sensors is added.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 94eebff..6b1568e 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -301,4 +301,27 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	camera {
+		status = "okay";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <>;
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
