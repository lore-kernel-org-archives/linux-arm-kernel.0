From: tobetter@gmail.com (Dongjin Kim)
Date: Wed, 24 Jul 2013 02:32:40 +0900
Subject: [PATCH] ARM: dts: Add USB host node for Exynos4
Message-ID: <1374600763-19466-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EHCI and OHCI host device nodes for Exynos4.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 3f94fe8..1cdbf89 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -155,6 +155,26 @@
 		status = "disabled";
 	};
 
+	ehci at 12580000 {
+		compatible = "samsung,exynos4210-ehci";
+		reg = <0x12580000 0x100>;
+		interrupts = <0 70 0>;
+		status = "disabled";
+
+		clocks = <&clock 304>;
+		clock-names = "usbhost";
+	};
+
+	ohci at 12590000 {
+		compatible = "samsung,exynos4210-ohci";
+		reg = <0x12580000 0x100>;
+		interrupts = <0 70 0>;
+		status = "disabled";
+
+		clocks = <&clock 304>;
+		clock-names = "usbhost";
+	};
+
 	mfc: codec at 13400000 {
 		compatible = "samsung,mfc-v5";
 		reg = <0x13400000 0x10000>;
-- 
1.7.9.5
