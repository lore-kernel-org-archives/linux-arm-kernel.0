From: ideal.song@samsung.com (Inha Song)
Date: Thu, 22 Jan 2015 20:18:01 +0900
Subject: [alsa-devel] [PATCH v3 3/4] ARM: dts: set clock out parent to XUSBXTI
In-Reply-To: <1421925482-15861-1-git-send-email-ideal.song@samsung.com>
References: <1421925482-15861-1-git-send-email-ideal.song@samsung.com>
Message-ID: <1421925482-15861-4-git-send-email-ideal.song@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set clock out parent to XUSBXTI.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8168f1..020bbaf 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -141,6 +141,8 @@
 	pmu_system_controller: system-controller at 10020000 {
 		compatible = "samsung,exynos4210-pmu", "syscon";
 		reg = <0x10020000 0x4000>;
+		assigned-clocks = <&pmu_system_controller 0>;
+		assigned-clock-parents =  <&clock CLK_XUSBXTI>;
 	};
 
 	dsi_0: dsi at 11C80000 {
-- 
2.0.0.390.gcb682f8
