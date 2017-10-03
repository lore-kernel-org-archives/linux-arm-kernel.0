From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:51:52 +0530
Subject: [PATCH 5/5] mailbox: Build Broadcom FlexRM driver as loadable module
 for iProc SOCs
In-Reply-To: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
References: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008112-27117-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, we build Broadcom FlexRM driver as loadable module for
iProc SOCs so that kernel image is little smaller and we load FlexRM
driver only when required.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3161f23..ba2f152 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -166,7 +166,7 @@ config BCM_FLEXRM_MBOX
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	depends on HAS_DMA
 	select GENERIC_MSI_IRQ_DOMAIN
-	default ARCH_BCM_IPROC
+	default m if ARCH_BCM_IPROC
 	help
 	  Mailbox implementation of the Broadcom FlexRM ring manager,
 	  which provides access to various offload engines on Broadcom
-- 
2.7.4
