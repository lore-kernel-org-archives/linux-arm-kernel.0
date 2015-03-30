From: matthew@mattleach.net (Matthew Leach)
Date: Mon, 30 Mar 2015 19:25:14 +0100
Subject: [PATCH] ARM: dts: exynos4412: Enable AX88760 USB hub on Origen board
Message-ID: <1427739914-24862-1-git-send-email-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Origen's usb phy and ohci devices in the device tree.  Also
add the "samsung,vbus-gpio" property to enable the GPX3(5) gpio pin so
the AX88760 hub is powered.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
---
 arch/arm/boot/dts/exynos4412-origen.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index bd8b730..c810ca3 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -531,4 +531,19 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	exynos-usbphy at 125B0000 {
+		status = "okay";
+	};
+
+	ehci at 12580000 {
+		samsung,vbus-gpio = <&gpx3 5 1>;
+		status = "okay";
+		port at 1{
+			status = "okay";
+		};
+		port at 2 {
+			status = "okay";
+		};
+	};
 };
-- 
2.3.4
