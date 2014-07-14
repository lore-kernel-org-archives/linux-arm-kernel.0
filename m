From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Jul 2014 15:32:14 +0800
Subject: [PATCH 2/5] rtc: sunxi: Depend on platforms sun4i/sun7i that actually
 have the rtc
In-Reply-To: <1405323137-24287-1-git-send-email-wens@csie.org>
References: <1405323137-24287-1-git-send-email-wens@csie.org>
Message-ID: <1405323137-24287-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have Kconfig options for individual sunxi platforms, let
the rtc-sunxi driver depend on the platforms that actually have this
hardware, sun4i and sun7i.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5b3910a..09a8d01 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1176,7 +1176,7 @@ config RTC_DRV_SUN6I
 
 config RTC_DRV_SUNXI
 	tristate "Allwinner sun4i/sun7i RTC"
-	depends on ARCH_SUNXI
+	depends on MACH_SUN4I || MACH_SUN7I
 	help
 	  If you say Y here you will get support for the RTC found on
 	  Allwinner A10/A20.
-- 
2.0.1
