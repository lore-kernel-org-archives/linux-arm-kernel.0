From: amstan@chromium.org (Alexandru M Stan)
Date: Wed,  2 Sep 2015 16:27:59 -0700
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Remove specific cts pullup from
 veyron
In-Reply-To: <1441236479-4941-1-git-send-email-amstan@chromium.org>
References: <1441236479-4941-1-git-send-email-amstan@chromium.org>
Message-ID: <1441236479-4941-3-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the previous patch ("rk3288: pull up cts lines") this is redundant,
I sent that patch for the same reason this existed here, so the lines don't
wiggle randomly when disconnected.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
---
Changes in v2:
- Restrict changes only to cts pin, leave rts alone
- CC people with the firefly board
- New patch removing redundant pullup code from veyron
- cover letter

 arch/arm/boot/dts/rk3288-veyron.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 2fa7a0d..2b5d2e2 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -543,18 +543,6 @@
 		};
 	};
 
-	/*
-	 * On Marvell-based hardware this is a no-connect.  Make sure we enable
-	 * the pullup so that the line doesn't float.  The pullup shouldn't
-	 * hurt on Broadcom-based hardware since the other side is actively
-	 * driving this signal.  As proof: we've already got a pullup on RX.
-	 */
-	uart0 {
-		uart0_cts: uart0-cts {
-			rockchip,pins = <4 18 RK_FUNC_1 &pcfg_pull_up>;
-		};
-	};
-
 	write-protect {
 		fw_wp_ap: fw-wp-ap {
 			rockchip,pins = <7 6 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.5.0.457.gab17608
