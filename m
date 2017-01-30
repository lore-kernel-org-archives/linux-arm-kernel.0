From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Mon, 30 Jan 2017 08:25:52 -0800
Subject: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
Message-ID: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to address PEM initialization issue
which causes network issues.

It is necessary to search for _HID:PNP0A08 while requesting
PEM resources via ACPI instead of "THRX0002".

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
---
 drivers/pci/host/pci-thunder-pem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index af722eb..aec30b8 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -331,7 +331,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
 	if (!res_pem)
 		return -ENOMEM;
 
-	ret = acpi_get_rc_resources(dev, "THRX0002", root->segment, res_pem);
+	ret = acpi_get_rc_resources(dev, "PNP0A08", root->segment, res_pem);
 	if (ret) {
 		dev_err(dev, "can't get rc base address\n");
 		return ret;
-- 
2.4.11
