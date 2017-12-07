From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu,  7 Dec 2017 19:21:02 +0100
Subject: [PATCH] ARM: dts: sun8i-h3: Remove allwinner,
 leds-active-low for non internal PHY
Message-ID: <20171207182102.16127-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

allwinner,leds-active-low have effect only on boards which us the internal PHY.
So this patch remove it from all boards which do not use the internal PHY.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 1 -
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts   | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts    | 1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index f2292deaa590..f1c3f1cc4d97 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -119,7 +119,6 @@
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
 
-	allwinner,leds-active-low;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 0a8b79cf5954..b9ffa4d9c873 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -83,8 +83,6 @@
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
 
-	allwinner,leds-active-low;
-
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index cbc499b04de4..b403e5d787cb 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -85,7 +85,6 @@
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
 
-	allwinner,leds-active-low;
 	status = "okay";
 };
 
-- 
2.13.6
