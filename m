From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 18 Jan 2013 12:40:12 +0100
Subject: [PATCH 2/4] mfd: dbx500-prcmu: export a9wdog functions
In-Reply-To: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
References: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1358509214-22407-3-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EXPORT_SYMBOL to db500_prcmu_*_a9wdog functions to allow usage from
module.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 268f45d..7a63fa8 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2212,21 +2212,25 @@ int db8500_prcmu_config_a9wdog(u8 num, bool sleep_auto_off)
 			    sleep_auto_off ? A9WDOG_AUTO_OFF_EN :
 			    A9WDOG_AUTO_OFF_DIS);
 }
+EXPORT_SYMBOL(db8500_prcmu_config_a9wdog);
 
 int db8500_prcmu_enable_a9wdog(u8 id)
 {
 	return prcmu_a9wdog(MB4H_A9WDOG_EN, id, 0, 0, 0);
 }
+EXPORT_SYMBOL(db8500_prcmu_enable_a9wdog);
 
 int db8500_prcmu_disable_a9wdog(u8 id)
 {
 	return prcmu_a9wdog(MB4H_A9WDOG_DIS, id, 0, 0, 0);
 }
+EXPORT_SYMBOL(db8500_prcmu_disable_a9wdog);
 
 int db8500_prcmu_kick_a9wdog(u8 id)
 {
 	return prcmu_a9wdog(MB4H_A9WDOG_KICK, id, 0, 0, 0);
 }
+EXPORT_SYMBOL(db8500_prcmu_kick_a9wdog);
 
 /*
  * timeout is 28 bit, in ms.
@@ -2244,6 +2248,7 @@ int db8500_prcmu_load_a9wdog(u8 id, u32 timeout)
 			    (u8)((timeout >> 12) & 0xff),
 			    (u8)((timeout >> 20) & 0xff));
 }
+EXPORT_SYMBOL(db8500_prcmu_load_a9wdog);
 
 /**
  * prcmu_abb_read() - Read register value(s) from the ABB.
-- 
1.7.12.1
