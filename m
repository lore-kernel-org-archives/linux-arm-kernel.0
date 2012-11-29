From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 29 Nov 2012 12:45:10 -0800
Subject: [PATCH 6/6] ie6xx_wdt: convert struct spinlock to spinlock_t
In-Reply-To: <1354221910-22493-1-git-send-email-mcgrof@do-not-panic.com>
References: <1354221910-22493-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1354221910-22493-7-git-send-email-mcgrof@do-not-panic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

spinlock_t should always be used.

  CHECK   drivers/watchdog/ie6xx_wdt.c
  CC [M]  drivers/watchdog/ie6xx_wdt.o
  Building modules, stage 2.
  MODPOST 43 modules
  LD [M]  drivers/watchdog/ie6xx_wdt.ko

Cc: Alexander Stein <alexander.stein@systec-electronic.com>
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 drivers/watchdog/ie6xx_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index e24ef6a..f2d6573 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -82,7 +82,7 @@ MODULE_PARM_DESC(resetmode,
 
 static struct {
 	unsigned short sch_wdtba;
-	struct spinlock unlock_sequence;
+	spinlock_t unlock_sequence;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 #endif
-- 
1.7.10.4
