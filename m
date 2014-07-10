From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jul 2014 23:36:31 +0200
Subject: [PATCH v2 11/12] rtc: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Message-ID: <1405028192-9623-12-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 0754f5c7cb3b..318cae5eab60 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1190,7 +1190,7 @@ config RTC_DRV_TX4939
 
 config RTC_DRV_MV
 	tristate "Marvell SoC RTC"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU
+	depends on ARCH_DOVE || ARCH_MVEBU
 	help
 	  If you say yes here you will get support for the in-chip RTC
 	  that can be found in some of Marvell's SoC devices, such as
-- 
2.0.1
