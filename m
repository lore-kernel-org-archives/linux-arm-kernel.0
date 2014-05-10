From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 May 2014 15:46:23 +0900
Subject: [PATCH v3 1/3] ARM: dts: Add PMU node to exynos4210
In-Reply-To: <1399704385-12508-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399704385-12508-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399704385-12508-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pmu regnode to exynos4210 dtsi to handle
PMU register access via DT.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index d3d727b..d23d3f0 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -99,6 +99,11 @@
 		interrupts = <2 2>, <3 2>;
 	};
 
+	pmu_system_controller: system-controller at 10020000 {
+		compatible = "samsung,exynos4210-pmu", "syscon";
+		reg = <0x10020000 0x5000>;
+	};
+
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11400000 0x1000>;
-- 
1.7.10.4
