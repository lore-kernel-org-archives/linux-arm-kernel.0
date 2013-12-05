From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 5 Dec 2013 14:42:46 -0800
Subject: [PATCH] ARM: dts: Leave sdio1 as disabled on bcm28155-ap
Message-ID: <1386283366-7273-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdio1 interface pins are routed to an unpopulated daughter card
connector on the bcm28155-ap board.  Thus there is no need to mark
this interface as enabled.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 08e47c2..d2e7769 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -27,11 +27,6 @@
 		status = "okay";
 	};
 
-	sdio1: sdio at 3f180000 {
-		max-frequency = <48000000>;
-		status = "okay";
-	};
-
 	sdio2: sdio at 3f190000 {
 		non-removable;
 		max-frequency = <48000000>;
-- 
1.8.0.1
