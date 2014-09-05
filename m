From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 5 Sep 2014 18:09:48 +0800
Subject: [PATCH v1 03/21] MSI: Remove the redundant irq_set_chip_data()
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1409911806-10519-4-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, pcie-designware, pcie-rcar, pci-tegra drivers
use irq chip_data to save the msi_chip pointer. They
already call irq_set_chip_data() in their own MSI irq map
functions. So irq_set_chip_data() in arch_setup_msi_irq()
is useless.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f6cb317..d547f7f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -41,8 +41,6 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	if (err < 0)
 		return err;
 
-	irq_set_chip_data(desc->irq, chip);
-
 	return 0;
 }
 
-- 
1.7.1
