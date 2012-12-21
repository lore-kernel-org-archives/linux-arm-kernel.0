From: tobetter@gmail.com (Dongjin Kim)
Date: Sat, 22 Dec 2012 02:37:01 +0900
Subject: [PATCH v2 2/4] ODROID-X: dts: Add fixed-regulator for peripherals.
In-Reply-To: <1356111423-3454-1-git-send-email-tobetter@gmail.com>
References: <1356111423-3454-1-git-send-email-tobetter@gmail.com>
Message-ID: <1356111423-3454-3-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the node to support fixed voltage for peripherals like LED,
ethernet controller.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 323ed177..3d53663 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -44,4 +44,14 @@
 		pinctrl-names = "default";
 		status = "okay";
 	};
+
+	regulator_p3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "p3v3_en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpa1 1 0>;
+		enable-active-high;
+		regulator-boot-on;
+	};
 };
-- 
1.7.9.5
