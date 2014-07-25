From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Jul 2014 17:13:24 +0800
Subject: [PATCH v3 2/6] rtc: sunxi: Depend on platforms sun4i/sun7i that
 actually have the rtc
In-Reply-To: <1406279608-489-1-git-send-email-wens@csie.org>
References: <1406279608-489-1-git-send-email-wens@csie.org>
Message-ID: <1406279608-489-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have Kconfig options for individual sunxi platforms, let
the rtc-sunxi driver depend on the platforms that actually have this
hardware, sun4i and sun7i.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index dde2b57..f933b4b 100644
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
