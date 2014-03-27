From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 27 Mar 2014 11:43:05 +0530
Subject: [PATCH V2 3/3] ARM: dts: Add node for GPIO keys on SMDK5420
In-Reply-To: <1395900785-11334-1-git-send-email-vikas.sajjan@samsung.com>
References: <1395900785-11334-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1395900785-11334-4-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

Add support for the suspend/resume button (SW7) on SMDK5420 using
gpio-keys driver.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 6910485..5ae0dd4 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -158,6 +158,17 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		wakeup {
+			label = "SW7";
+			gpios = <&gpx0 0 1>;
+			linux,code = <143>;	/* KEY_WAKEUP */
+			gpio-key,wakeup;
+		};
+	};
+
 	hsi2c_4: i2c at 12CA0000 {
 		status = "okay";
 
-- 
1.7.9.5
