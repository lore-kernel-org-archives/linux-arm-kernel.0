From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Jul 2014 14:22:04 +0200
Subject: [PATCH 2/3] ARM: dts: exynos: Add PMU to Exynos5410
In-Reply-To: <1406463725-4208-1-git-send-email-afaerber@suse.de>
References: <1406463725-4208-1-git-send-email-afaerber@suse.de>
Message-ID: <1406463725-4208-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos initialization code now relies on obtaining the PMU address,
so prepare a PMU node for Exynos5410.

Fixes: fce9e5bb2526 ("ARM: EXYNOS: Add support for mapping PMU base address via DT")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5410.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 9d0b8cc1409c..790d4886d7b5 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -91,6 +91,11 @@
 			reg = <0x10000000 0x100>;
 		};
 
+		pmu_system_controller: system-controller at 10040000 {
+			compatible = "samsung,exynos5410-pmu", "syscon";
+			reg = <0x10040000 0x5000>;
+		};
+
 		mct: mct at 101C0000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x101C0000 0xB00>;
-- 
1.9.3
