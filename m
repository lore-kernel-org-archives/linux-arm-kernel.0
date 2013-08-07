From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 07 Aug 2013 14:20:34 +0530
Subject: [PATCH 1/3] ARM: dts: Enable sound support on smdk5420
In-Reply-To: <1375865442-5323-1-git-send-email-padma.v@samsung.com>
References: <1375865442-5323-1-git-send-email-padma.v@samsung.com>
Message-ID: <1375865442-5323-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables i2s0 and sound support on smdk5420.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index e86c1ae..b979405 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -126,4 +126,14 @@
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
