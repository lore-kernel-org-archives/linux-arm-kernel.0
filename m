From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  3 Mar 2011 14:30:56 +0100
Subject: [PATCH 2/6] rtc i.MX Dryice: use IMX_HAVE_PLATFORM_IMXDI_RTC to
	depend on
In-Reply-To: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
References: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1299159060-9289-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX architecture provides IMX_HAVE_PLATFORM_* macros to signal
that a selected SoC supports a certain hardware. Use them instead of
depending on ARCH_* directly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4941cad..0d73a65 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -581,7 +581,7 @@ config RTC_DRV_MSM6242
 
 config RTC_DRV_IMXDI
 	tristate "Freescale IMX DryIce Real Time Clock"
-	depends on ARCH_MX25
+	depends on IMX_HAVE_PLATFORM_IMXDI_RTC
 	depends on RTC_CLASS
 	help
 	   Support for Freescale IMX DryIce RTC
-- 
1.7.2.3
