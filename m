From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  2 Jan 2015 16:24:16 +0100
Subject: [PATCH RESEND 3/4] ARM: dts: Set Peach boards USB WebCam regulators
 to always on
In-Reply-To: <1420212257-22443-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1420212257-22443-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1420212257-22443-4-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5420 Peach Pit and Exynos5800 Peach Pi boards have a built-in
Silicon Motion USB UVC WebCam whose power supply is the tps65090 fet5
regulator. Since the camera uses the generic USB Video Class driver and
this does not grab a regulator, mark the regulator as always on so the
USB device is enumerated and usable.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index fa74a73..a4c5152 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -831,6 +831,7 @@
 					};
 					tps65090_fet5: fet5 {
 						regulator-name = "camout";
+						regulator-always-on;
 					};
 					tps65090_fet6: fet6 {
 						regulator-name = "lcd_vdd";
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index d603e73..1367276 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -820,6 +820,7 @@
 					};
 					tps65090_fet5: fet5 {
 						regulator-name = "camout";
+						regulator-always-on;
 					};
 					tps65090_fet6: fet6 {
 						regulator-name = "lcd_vdd";
-- 
2.1.3
