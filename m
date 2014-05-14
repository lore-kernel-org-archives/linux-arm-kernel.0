From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 14 May 2014 08:16:01 +0530
Subject: [PATCH v4 4/5] ARM: dts: remove chip specific hdmi hpd pin from board
In-Reply-To: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
References: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1400035562-16832-5-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

"gpx3-7" is chip specific pin in Exynos5420 for hdmi
hotplug. This pin is moved to exynos5420-pinctrl.dts
and removed from the board file.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 6910485..11cd9bf 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -131,15 +131,6 @@
 		};
 	};
 
-	pinctrl at 13400000 {
-		hdmi_hpd_irq: hdmi-hpd-irq {
-			samsung,pins = "gpx3-7";
-			samsung,pin-function = <0>;
-			samsung,pin-pud = <1>;
-			samsung,pin-drv = <0>;
-		};
-	};
-
 	hdmi at 14530000 {
 		status = "okay";
 		hpd-gpio = <&gpx3 7 0>;
-- 
1.7.9.5
