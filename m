From: tobetter@gmail.com (Dongjin Kim)
Date: Tue,  6 Aug 2013 03:09:19 +0900
Subject: [PATCH RESEND] ARM: dts: Add USB host node for Exynos4
Message-ID: <1375726159-20486-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EHCI and OHCI host device nodes for Exynos4.

CC: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 3f94fe8..cbe5219 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -155,6 +155,24 @@
 		status = "disabled";
 	};
 
+	ehci at 12580000 {
+		compatible = "samsung,exynos4210-ehci";
+		reg = <0x12580000 0x100>;
+		interrupts = <0 70 0>;
+		clocks = <&clock 304>;
+		clock-names = "usbhost";
+		status = "disabled";
+	};
+
+	ohci at 12590000 {
+		compatible = "samsung,exynos4210-ohci";
+		reg = <0x12590000 0x100>;
+		interrupts = <0 70 0>;
+		clocks = <&clock 304>;
+		clock-names = "usbhost";
+		status = "disabled";
+	};
+
 	mfc: codec at 13400000 {
 		compatible = "samsung,mfc-v5";
 		reg = <0x13400000 0x10000>;
-- 
1.7.9.5
