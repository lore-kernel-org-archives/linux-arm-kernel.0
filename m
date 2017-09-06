From: deller@gmx.de (Helge Deller)
Date: Wed,  6 Sep 2017 22:27:51 +0200
Subject: [PATCH 04/14] ti_sci: Use %pS printk format for direct addresses
In-Reply-To: <1504729681-3504-1-git-send-email-deller@gmx.de>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
Message-ID: <1504729681-3504-5-git-send-email-deller@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the %pS printk format for printing symbols from direct addresses.
This is important for the ia64, ppc64 and parisc64 architectures, while on
other architectures there is no difference between %pS and %pF.
Fix it for consistency across the kernel.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 00cfed3..23b12d9 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -439,7 +439,7 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 	/* And we wait for the response. */
 	timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 	if (!wait_for_completion_timeout(&xfer->done, timeout)) {
-		dev_err(dev, "Mbox timedout in resp(caller: %pF)\n",
+		dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
 			(void *)_RET_IP_);
 		ret = -ETIMEDOUT;
 	}
-- 
2.1.0
