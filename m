From: tobetter@gmail.com (Dongjin Kim)
Date: Tue, 18 Dec 2012 02:59:32 +0900
Subject: [PATCH] ARM: dts: Add node for MSHC controller for Exynos4
Message-ID: <1355767207-18744-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MSHC controller node to the device tree (DT).
---
 arch/arm/boot/dts/exynos4.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e1347fc..1b82921 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -131,6 +131,14 @@
 		status = "disabled";
 	};
 
+	mshc at 12550000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12550000 0x1000>;
+		interrupts = <0 77 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	serial at 13800000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
-- 
1.7.9.5
