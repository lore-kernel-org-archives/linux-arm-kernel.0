From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  1 Aug 2017 16:05:52 +0530
Subject: [PATCH v3 3/5] mailbox: bcm-flexrm-mailbox: Fix mask used in
 CMPL_START_ADDR_VALUE()
In-Reply-To: <1501583754-31969-1-git-send-email-anup.patel@broadcom.com>
References: <1501583754-31969-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1501583754-31969-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mask used in CMPL_START_ADDR_VALUE() should be 27bits instead of
26bits. This incorrect mask was causing completion writes to 40bits
physical address fail.

This patch fixes mask used in CMPL_START_ADDR_VALUE() macro.

Fixes: dbc049eee730 ("mailbox: Add driver for Broadcom FlexRM
ring manager")

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Cc: stable at vger.kernel.org
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index a0be2ea..46ad305 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -97,7 +97,7 @@
 
 /* Register RING_CMPL_START_ADDR fields */
 #define CMPL_START_ADDR_VALUE(pa)			\
-	((u32)((((u64)(pa)) >> RING_CMPL_ALIGN_ORDER) & 0x03ffffff))
+	((u32)((((u64)(pa)) >> RING_CMPL_ALIGN_ORDER) & 0x07ffffff))
 
 /* Register RING_CONTROL fields */
 #define CONTROL_MASK_DISABLE_CONTROL			12
-- 
2.7.4
