From: wxt@rock-chips.com (Caesar Wang)
Date: Sun, 20 Dec 2015 18:30:34 +0800
Subject: [PATCH] ARM: dts: veyron: enable the tsadc on pinky board
Message-ID: <1450607434-6733-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think the tsadc is fakly hand on pinky board,
maybe that's fixed in newest kernel.
As the following patch is a example:
https://patchwork.kernel.org/patch/7472051/

I don't have meet this issue on pinky board.
Let me know if that's still hanging on pinky board.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3288-veyron-pinky.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
index 94b56e3..b587ebf 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
@@ -121,8 +121,3 @@
 		     &sdmmc_wp_gpio &sdmmc_bus4>;
 	wp-gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>;
 };
-
-&tsadc {
-	/* Some connection is flaky making the tsadc hang the system */
-	status = "disabled";
-};
-- 
1.9.1
