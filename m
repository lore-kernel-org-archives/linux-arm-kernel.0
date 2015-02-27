From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Feb 2015 16:09:53 +0100
Subject: [PATCH 1/6] PM / wakeup: export pm_system_wakeup symbol
In-Reply-To: <1425049798-5891-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425049798-5891-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1425049798-5891-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export pm_system_wakeup function to allow irq handlers to deal with system
wakeup.
This is needed for shared IRQ lines where one of the handler is registered
with IRQF_NO_SUSPEND, while the other ones want to configure it as a wakeup
source.
In this specific case, irq core does not handle the wakeup process and
leave the decision to each irq handler.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/base/power/wakeup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index c2744b3..aab7158 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -730,6 +730,7 @@ void pm_system_wakeup(void)
 	pm_abort_suspend = true;
 	freeze_wake();
 }
+EXPORT_SYMBOL_GPL(pm_system_wakeup);
 
 void pm_wakeup_clear(void)
 {
-- 
1.9.1
