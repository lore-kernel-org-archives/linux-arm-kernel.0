From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:50 +0100
Subject: [PATCH 49/77] ARM: dts: sun7i: Remove redundant MMC pinmux tuning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <2a975ba9be2960b0d8389c51e2621e922e218f0a.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards override the MMC pin muxing settings in order to enable the
pull-ups and change the drive strength to a value higher than the default.

While this was needed in the earlier days, this is now the default setting
for those pins, and therefore we don't need those board-specific settings
anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 5 -----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       | 5 -----
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index e2e540380c6e..e2bfe0058830 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -197,11 +197,6 @@
 	};
 };
 
-&mmc3_pins {
-	/* AP6210 requires pull-up */
-	bias-pull-up;
-};
-
 &ohci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 95da354cecb7..15c5eae4ca7b 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -215,11 +215,6 @@
 	};
 };
 
-&mmc3_pins {
-	/* AP6210 requires pull-up */
-	bias-pull-up;
-};
-
 &ohci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 6313d8a8a37c..5f1c4f573d3e 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -167,11 +167,6 @@
 	};
 };
 
-&mmc3_pins {
-	/* AP6210 / AP6330 requires pull-up */
-	bias-pull-up;
-};
-
 &ohci0 {
 	status = "okay";
 };
-- 
git-series 0.9.1
