From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 06 Jun 2013 10:51:42 +0900
Subject: [PATCH] ARM: dts: add ohci and ehci controller nodes for EXYNOS5440
Message-ID: <09d701ce6258$64ef1fc0$2ecd5f40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

EXYNOS5440 includes both OHCI and EHCI usb host controllers.
Add device tree nodes for both of these controllers.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 2607739..f3faabf 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -225,4 +225,19 @@
 		clock-names = "sata";
 	};
 
+	ohci at 220000 {
+		compatible = "samsung,exynos-ohci";
+		reg = <0x220000 0x1000>;
+		interrupts = <0 29 0>;
+		clocks = <&clock 24>;
+		clock-names = "usbhost";
+	};
+
+	ehci at 221000 {
+		compatible = "samsung,exynos-ehci";
+		reg = <0x221000 0x1000>;
+		interrupts = <0 29 0>;
+		clocks = <&clock 24>;
+		clock-names = "usbhost";
+	};
 };
-- 
1.7.10.4
