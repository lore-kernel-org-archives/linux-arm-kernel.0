From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 May 2014 15:46:24 +0900
Subject: [PATCH v3 2/3] ARM: dts: Add PMU node to exynos4212 and exynos4412
In-Reply-To: <1399704385-12508-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399704385-12508-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399704385-12508-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pmu regnode to exynos4212 and exynos4412 dtsi to
handle PMU register access via DT.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi |    5 +++++
 arch/arm/boot/dts/exynos4412.dtsi |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 3c00e6e..4661ffa 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -29,4 +29,9 @@
 	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
+
+	pmu_system_controller: system-controller at 10020000 {
+		compatible = "samsung,exynos4212-pmu", "syscon";
+		reg = <0x10020000 0x5000>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 15d3c0a..6f4cb22 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -29,4 +29,9 @@
 	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x4000>;
 	};
+
+	pmu_system_controller: system-controller at 10020000 {
+		compatible = "samsung,exynos4412-pmu", "syscon";
+		reg = <0x10020000 0x5000>;
+	};
 };
-- 
1.7.10.4
