From: tobetter@gmail.com (Dongjin Kim)
Date: Sat, 22 Dec 2012 02:16:54 +0900
Subject: [PATCH] ARM: dts: Add node for MSHC controller for Exynos4
Message-ID: <1356110218-2423-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MSHC controller node to the device tree (DT).

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e1347fc..92bca86 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -131,6 +131,15 @@
 		status = "disabled";
 	};
 
+	mshc at 12550000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12550000 0x1000>;
+		interrupts = <0 77 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	serial at 13800000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
-- 
1.7.9.5
