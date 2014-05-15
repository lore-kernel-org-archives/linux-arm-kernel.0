From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 16:23:55 +0200
Subject: [PATCH RFC 10/11] rtc: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Message-ID: <1400163836-9831-15-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 2e565f8e5165..93be35954cee 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1161,7 +1161,7 @@ config RTC_DRV_TX4939
 
 config RTC_DRV_MV
 	tristate "Marvell SoC RTC"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU
+	depends on ARCH_DOVE || ARCH_MVEBU
 	help
 	  If you say yes here you will get support for the in-chip RTC
 	  that can be found in some of Marvell's SoC devices, such as
-- 
2.0.0.rc2
