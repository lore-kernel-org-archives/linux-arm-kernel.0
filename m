From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  1 Feb 2016 17:39:22 +0000
Subject: [PATCH 03/11] drivers: rtc: allow compilation of sun6i RTC for all
 sunxi SoCs
In-Reply-To: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment the "sun6i" RTC drivers depends on having two specific
SoC families selected.
The Allwinner A64 SoC has the same RTC, so extend the Kconfig option
to allow inclusion of the driver for all Allwinner SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/rtc/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f..526eaf4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1360,10 +1360,11 @@ config RTC_DRV_SUN4V
 
 config RTC_DRV_SUN6I
 	tristate "Allwinner A31 RTC"
-	depends on MACH_SUN6I || MACH_SUN8I
+	default MACH_SUN6I || MACH_SUN8I
+	depends on ARCH_SUNXI
 	help
-	  If you say Y here you will get support for the RTC found on
-	  Allwinner A31.
+	  If you say Y here you will get support for the RTC found in
+	  some Allwinner SoCs like the A31 or the A64.
 
 config RTC_DRV_SUNXI
 	tristate "Allwinner sun4i/sun7i RTC"
-- 
2.6.4
