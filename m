From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 07 Aug 2013 14:40:16 +0530
Subject: [PATCH V3 7/7] ARM: dts: Enable sound support on smdk5420
In-Reply-To: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
Message-ID: <1375866616-5541-8-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables i2s0 and sound support on smdk5420.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 3c56a91..a9eab45 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -136,4 +136,14 @@
 		};
 	};
 
+	i2s0: i2s at 03830000 {
+		status = "okay";
+	};
+
+	sound {
+		compatible = "samsung,smdk-wm8994";
+
+		samsung,i2s-controller = <&i2s0>;
+		samsung,audio-codec = <&wm8994>;
+	};
 };
-- 
1.7.4.4
