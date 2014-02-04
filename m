From: tim.kryger@linaro.org (Tim Kryger)
Date: Tue, 4 Feb 2014 15:27:40 -0800
Subject: [PATCH v2] ARM: dts: Leave sdio1 as disabled on bcm28155-ap
Message-ID: <1391556460-24218-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdio1 interface pins are routed to an unpopulated daughter card
connector on the bcm28155-ap board.  Thus there is no need to mark
this interface as enabled.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---

Changes since v1:
  - Rebased on v3.14-rc1

 arch/arm/boot/dts/bcm28155-ap.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 5ff2382..3604554 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -49,11 +49,6 @@
 		clock-frequency = <400000>;
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
