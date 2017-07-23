From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 24 Jul 2017 00:23:26 +0100
Subject: [PATCH v2 3/3] mailbox: Kconfig: enable ARM SMC mailbox on 64-bit
 Allwinner SoCs
In-Reply-To: <1500852206-28771-1-git-send-email-andre.przywara@arm.com>
References: <1500852206-28771-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1500852206-28771-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 64-bit Allwinner SoCs there exist firmware implementations which
provide SCPI controlled handlers for DVFS, sensors and power domains.
To allow usage of this features, enable the required SMC mailbox when
Allwinner SoCs are supported by the kernel.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 5664b7f..6d6e8bb 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -174,6 +174,7 @@ config BCM_FLEXRM_MBOX
 config ARM_SMC_MBOX
 	tristate "Generic ARM smc mailbox"
 	depends on OF && HAVE_ARM_SMCCC
+	default y if ARM64 && ARCH_SUNXI
 	help
 	  Generic mailbox driver which uses ARM smc calls to call into
 	  firmware for triggering mailboxes.
-- 
2.8.2
