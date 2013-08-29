From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 29 Aug 2013 10:58:29 +0530
Subject: [PATCH 5/6] ARM: dts: add hdmi hpd gpio pinctrl node for exynos5420
In-Reply-To: <1377754110-31084-1-git-send-email-rahul.sharma@samsung.com>
References: <1377754110-31084-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1377754110-31084-5-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl node for hdmi-hpd gpio pin to exynos5420
device tree files.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 140565f..79524c7 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -61,9 +61,20 @@
 		};
 	};
 
+	pinctrl at 13400000 {
+		hdmi_hpd_irq: hdmi-hpd-irq {
+			samsung,pins = "gpx3-7";
+			samsung,pin-function = <0>;
+			samsung,pin-pud = <1>;
+			samsung,pin-drv = <0>;
+		};
+	};
+
 	hdmi at 14530000 {
 		status = "okay";
 		hpd-gpio = <&gpx3 7 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_irq>;
 	};
 
 	i2c_2: i2c at 12C80000 {
-- 
1.7.10.4
