From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri,  4 Jun 2010 03:07:34 +0200
Subject: [PATCH 3/3] wm97xx_batt: Remove redundant header file
In-Reply-To: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
References: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1275613654-23918-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 include/linux/wm97xx_batt.h |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)
 delete mode 100644 include/linux/wm97xx_batt.h

diff --git a/include/linux/wm97xx_batt.h b/include/linux/wm97xx_batt.h
deleted file mode 100644
index a1d6419..0000000
--- a/include/linux/wm97xx_batt.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef _LINUX_WM97XX_BAT_H
-#define _LINUX_WM97XX_BAT_H
-
-#include <linux/wm97xx.h>
-
-#warning This file will be removed soon, use wm97xx.h instead!
-
-#define wm97xx_batt_info wm97xx_batt_pdata
-
-#ifdef CONFIG_BATTERY_WM97XX
-void wm97xx_bat_set_pdata(struct wm97xx_batt_info *data);
-#else
-static inline void wm97xx_bat_set_pdata(struct wm97xx_batt_info *data) {}
-#endif
-
-#endif
-- 
1.7.1
