From: majun258@huawei.com (MaJun)
Date: Wed, 23 Mar 2016 17:06:33 +0800
Subject: [PATCH 2/2] irqchip/mbigen:Change the config option of mbigen driver
 to non-configurable
In-Reply-To: <1458723993-21044-1-git-send-email-majun258@huawei.com>
References: <1458723993-21044-1-git-send-email-majun258@huawei.com>
Message-ID: <1458723993-21044-3-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

This config is selected by CONFIG_ARCH_HISI, So we change
this config to non-configurable.

I also adjust the mbigen config position try to sort the configs
in alphabetical order.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/Kconfig |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7e8c441..3e12479 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -32,14 +32,6 @@ config ARM_GIC_V3_ITS
 	bool
 	select PCI_MSI_IRQ_DOMAIN
 
-config HISILICON_IRQ_MBIGEN
-	bool "Support mbigen interrupt controller"
-	default n
-	depends on ARM_GIC_V3 && ARM_GIC_V3_ITS && GENERIC_MSI_IRQ_DOMAIN
-	help
-	 Enable the mbigen interrupt controller used on
-	 Hisilicon platform.
-
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN
@@ -114,6 +106,12 @@ config DW_APB_ICTL
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config HISILICON_IRQ_MBIGEN
+	bool
+	select ARM_GIC_V3
+	select ARM_GIC_V3_ITS
+	select GENERIC_MSI_IRQ_DOMAIN
+
 config IMGPDC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
-- 
1.7.1
