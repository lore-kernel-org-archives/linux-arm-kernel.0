From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 30 Aug 2014 18:46:10 +0200
Subject: [Patch v3] 5/7] rtc: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Message-ID: <1409417172-6846-6-git-send-email-andrew@lunn.ch>
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
index a168e96142b9..fae9464eed9c 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1198,7 +1198,7 @@ config RTC_DRV_TX4939
 
 config RTC_DRV_MV
 	tristate "Marvell SoC RTC"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU
+	depends on ARCH_DOVE || ARCH_MVEBU
 	help
 	  If you say yes here you will get support for the in-chip RTC
 	  that can be found in some of Marvell's SoC devices, such as
-- 
2.1.0
