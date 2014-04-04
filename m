From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  4 Apr 2014 12:57:26 -0700
Subject: [PATCH v6 1/5] genirq: export percpu irq functions for module usage
In-Reply-To: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
References: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1396641450-12854-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the near future we're going to use these percpu irq functions
in the Krait CPU EDAC driver. Export them so that the EDAC driver
can be compiled as a module.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 kernel/irq/manage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2486a4c1a710..7955580e634f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1705,6 +1705,7 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 	kfree(__free_percpu_irq(irq, dev_id));
 	chip_bus_sync_unlock(desc);
 }
+EXPORT_SYMBOL_GPL(free_percpu_irq);
 
 /**
  *	setup_percpu_irq - setup a per-cpu interrupt
@@ -1775,3 +1776,4 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
 
 	return retval;
 }
+EXPORT_SYMBOL_GPL(request_percpu_irq);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
