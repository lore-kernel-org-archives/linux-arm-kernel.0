From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sun,  2 Jul 2017 14:31:57 +0200
Subject: [PATCH 4/6] arm: sun8i: orangepi-zero: revert "use internal phy-mode"
In-Reply-To: <20170702123159.6939-1-clabbe.montjoie@gmail.com>
References: <20170702123159.6939-1-clabbe.montjoie@gmail.com>
Message-ID: <20170702123159.6939-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since internal phy-mode is reserved for non-xMII protocol we cannot use
it with dwmac-sun8i
This reverts commit 6066de6848d4 ("arm: sun8i: orangepi-zero: use internal phy-mode")

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 7c154b845baa..6713d0f2b3f4 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -106,7 +106,7 @@
 
 &emac {
 	phy-handle = <&int_mii_phy>;
-	phy-mode = "internal";
+	phy-mode = "mii";
 	allwinner,leds-active-low;
 	status = "okay";
 };
-- 
2.13.0
