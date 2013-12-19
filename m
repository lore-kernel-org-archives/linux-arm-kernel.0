From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Dec 2013 14:36:18 -0800
Subject: [PATCH 3/3] ARM: dts: Fix exynos5250-snow's search key to be L_META
In-Reply-To: <1387492578-22068-1-git-send-email-dianders@chromium.org>
References: <1387492578-22068-1-git-send-email-dianders@chromium.org>
Message-ID: <1387492578-22068-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree sent upstream for exynos5250-snow encoded the search
key as CAPSLK.  However in all ChromeOS kernels it is L_META.  One can
certainly have long debates about which it ought to be, but I'm
proposing setting it to L_META because:
* That's how _all_ ChromeOS kernels do it and will do it.
* There is no L_META key on the board, so it's nice to have.
* For those people who really want it to be caps lock, they can use
  xmodmap or somesuch.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 28fe2e2..c65f52a 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -85,7 +85,7 @@
 				        keypad,num-rows = <8>;
 				        keypad,num-columns = <13>;
 				        google,needs-ghost-filter;
-					linux,keymap = <0x0001003a	/* CAPSLK */
+					linux,keymap = <0x0001007d	/* L_META */
 							0x0002003b	/* F1 */
 							0x00030030	/* B */
 							0x00040044	/* F10 */
-- 
1.8.5.1
