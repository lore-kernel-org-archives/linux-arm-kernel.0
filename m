From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Jun 2013 00:22:48 +0200
Subject: [PATCH 11/15] iwlegacy: il_pm_ops is only provided for PM_SLEEP
In-Reply-To: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
Message-ID: <1370038972-2318779-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes sure the conditionals for the declaration match the
definition, so we provide the alternative

 #else
 #define IL_LEGACY_PM_OPS NULL
 #endif

in the correct cases. As suggested by Borislav Petkov, this removes
the comments for the #else and #endif lines.

drivers/built-in.o:(.data+0x57974): undefined reference to `il_pm_ops'

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: John W. Linville <linville@tuxdriver.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/iwlegacy/common.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/iwlegacy/common.h b/drivers/net/wireless/iwlegacy/common.h
index f8246f2..30dda98 100644
--- a/drivers/net/wireless/iwlegacy/common.h
+++ b/drivers/net/wireless/iwlegacy/common.h
@@ -1832,14 +1832,14 @@ u32 il_usecs_to_beacons(struct il_priv *il, u32 usec, u32 beacon_interval);
 __le32 il_add_beacon_time(struct il_priv *il, u32 base, u32 addon,
 			  u32 beacon_interval);
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops il_pm_ops;
 
 #define IL_LEGACY_PM_OPS	(&il_pm_ops)
 
-#else /* !CONFIG_PM */
+#else
 
-#define IL_LEGACY_PM_OPS	NULL
+#define
 
 #endif /* !CONFIG_PM */
 
-- 
1.8.1.2
