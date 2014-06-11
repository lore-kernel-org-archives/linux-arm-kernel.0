From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 11 Jun 2014 17:30:12 +0200
Subject: [PATCH 5/5] ARM: dts: exynos4: Add nodes for L2 cache controller
In-Reply-To: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
References: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
Message-ID: <1402500612-4778-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes for L2 cache controller present on
Exynos4 SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 9 +++++++++
 arch/arm/boot/dts/exynos4x12.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index ee3001f..99970ab 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -54,6 +54,15 @@
 		reg = <0x10023CA0 0x20>;
 	};
 
+	l2c: l2-cache-controller at 10502000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x10502000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+		arm,tag-latency = <2 2 1>;
+		arm,data-latency = <2 2 1>;
+	};
+
 	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c5a943d..9487f9c 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -60,6 +60,15 @@
 		reg = <0x10023CA0 0x20>;
 	};
 
+	l2c: l2-cache-controller at 10502000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x10502000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+		arm,tag-latency = <2 2 1>;
+		arm,data-latency = <3 2 1>;
+	};
+
 	clock: clock-controller at 10030000 {
 		compatible = "samsung,exynos4412-clock";
 		reg = <0x10030000 0x20000>;
-- 
1.9.3
