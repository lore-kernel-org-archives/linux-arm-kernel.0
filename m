From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Mon, 16 Dec 2013 17:31:11 +0530
Subject: [PATCH 2/2] ARM: dts: Add node for GPIO keys on SMDK5420
In-Reply-To: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1387195271-3613-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the suspend/resume button (SW7) on SMDK5420 using
gpio-keys driver.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index fb5a1e2..015e8b7 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -120,4 +120,15 @@
 			reg = <0x50>;
 		};
 	};
+
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
 };
-- 
1.7.9.5
