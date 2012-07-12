From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 12 Jul 2012 10:25:48 +0530
Subject: [PATCH] ARM: Exynos: Add device tree node for Exynos4 interrupt
 combiner controller
Message-ID: <1342068948-20755-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for Exynos4 interrupt combiner controller.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4210.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index a1dd2ee..0e4f659 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -33,6 +33,17 @@
 		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
 	};
 
+	combiner:interrupt-controller at 10440000 {
+		compatible = "samsung,exynos4210-combiner";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		reg = <0x10440000 0x1000>;
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
+	};
+
 	watchdog at 10060000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x10060000 0x100>;
-- 
1.6.6.rc2
