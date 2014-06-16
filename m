From: r.sricharan@ti.com (Sricharan R)
Date: Mon, 16 Jun 2014 16:53:11 +0530
Subject: [PATCH V3 11/16] irqchip: crossbar: set cb pointer to null in case of
 error
In-Reply-To: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1402917796-31574-12-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If crossbar_of_init returns with a error, then set the cb pointer
to null.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 5bd7f3d..9b4c0f1 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -250,6 +250,8 @@ err_base:
 	iounmap(cb->crossbar_base);
 err_cb:
 	kfree(cb);
+
+	cb = NULL;
 	return ret;
 }
 
-- 
1.7.9.5
