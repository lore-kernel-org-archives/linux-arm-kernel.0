From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 11 Apr 2013 17:14:53 +0530
Subject: [PATCH] ARM: dts: add ohci and ehci controller nodes for Exynos5440
 SoC
Message-ID: <1365680693-22449-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5440 includes both OHCI and EHCI usb host controllers. Add device tree
nodes for both of these controllers.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 0607ae5..4448b55 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -208,4 +208,19 @@
 		clock-names = "sata";
 	};
 
+	ohci at 220000 {
+		compatible = "samsung,exynos5440-ohci";
+		reg = <0x220000 0x1000>;
+		interrupts = <0 29 0>;
+		clocks = <&clock 11>;
+		clock-names = "usbhost";
+	};
+
+	ehci at 221000 {
+		compatible = "samsung,exynos5440-ehci";
+		reg = <0x221000 0x1000>;
+		interrupts = <0 29 0>;
+		clocks = <&clock 11>;
+		clock-names = "usbhost";
+	};
 };
-- 
1.6.6.rc2
