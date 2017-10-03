From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:51:50 +0530
Subject: [PATCH 3/5] mailbox: bcm-flexrm-mailbox: add depends on ARCH_BCM_IPROC
In-Reply-To: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
References: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008112-27117-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Scott Branden <scott.branden@broadcom.com>

The Broadcom FlexRM Mailbox is only present in the Broadcom IPROC SoCs.
Add depends on ARCH_BCM_IPROC to BCM_FLEXRX_MBOX.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c5731e5..3161f23 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -163,6 +163,7 @@ config BCM_PDC_MBOX
 config BCM_FLEXRM_MBOX
 	tristate "Broadcom FlexRM Mailbox"
 	depends on ARM64
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	depends on HAS_DMA
 	select GENERIC_MSI_IRQ_DOMAIN
 	default ARCH_BCM_IPROC
-- 
2.7.4
