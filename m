From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 29 Mar 2017 11:00:55 +0530
Subject: [PATCH v7 3/3] mailbox: Remove depends on COMPILE_TEST for
 BCM_FLEXRM_MBOX
In-Reply-To: <1490765455-8556-1-git-send-email-anup.patel@broadcom.com>
References: <1490765455-8556-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1490765455-8556-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom FlexRM mailbox driver uses platform MSI support but
not all ARCHs provide asm/msi.h. Due to this, we get compilation
error in Broadcom FlexRM mailbox driver via linux/msi.h on ARCHs
which lack asm/msi.h.

This patch removes "depends on COMPILE_TEST" for Kconfig option
BCM_FLEXRM_MBOX so that Broadcom FlexRM mailbox driver is only
compiled for ARM64.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 305018c..9c19b9f 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -155,7 +155,7 @@ config BCM_PDC_MBOX
 
 config BCM_FLEXRM_MBOX
 	tristate "Broadcom FlexRM Mailbox"
-	depends on ARM64 || COMPILE_TEST
+	depends on ARM64
 	depends on HAS_DMA
 	select GENERIC_MSI_IRQ_DOMAIN
 	default ARCH_BCM_IPROC
-- 
2.7.4
