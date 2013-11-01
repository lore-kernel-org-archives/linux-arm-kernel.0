From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  1 Nov 2013 09:31:52 -0700
Subject: [PATCH v3 2/6] genirq: export percpu irq functions for module usage
In-Reply-To: <1383323516-31357-1-git-send-email-sboyd@codeaurora.org>
References: <1383323516-31357-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1383323516-31357-3-git-send-email-sboyd@codeaurora.org>
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
index 514bcfd..c6009d1 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1623,6 +1623,7 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 	kfree(__free_percpu_irq(irq, dev_id));
 	chip_bus_sync_unlock(desc);
 }
+EXPORT_SYMBOL_GPL(free_percpu_irq);
 
 /**
  *	setup_percpu_irq - setup a per-cpu interrupt
@@ -1693,3 +1694,4 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
 
 	return retval;
 }
+EXPORT_SYMBOL_GPL(request_percpu_irq);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
