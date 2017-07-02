From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sun,  2 Jul 2017 14:31:55 +0200
Subject: [PATCH 2/6] arm: sun8i: orangepi-2: revert "use internal phy-mode"
In-Reply-To: <20170702123159.6939-1-clabbe.montjoie@gmail.com>
References: <20170702123159.6939-1-clabbe.montjoie@gmail.com>
Message-ID: <20170702123159.6939-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since internal phy-mode is reserved for non-xMII protocol we cannot use
it with dwmac-sun8i
This reverts commit 5a79b4f2a5e7 ("arm: sun8i: orangepi-2: use internal phy-mode")

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index a2a2b11dfeed..17cdeae19c6f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -120,7 +120,7 @@
 
 &emac {
 	phy-handle = <&int_mii_phy>;
-	phy-mode = "internal";
+	phy-mode = "mii";
 	allwinner,leds-active-low;
 	status = "okay";
 };
-- 
2.13.0
