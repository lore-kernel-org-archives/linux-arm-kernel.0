From: xiaowei.bao@nxp.com (Xiaowei Bao)
Date: Mon,  5 Nov 2018 16:46:53 +0800
Subject: [PATCHv2 6/6] misc: pci_endpoint_test: Add the layerscape EP device
 support
In-Reply-To: <20181105084653.26597-1-xiaowei.bao@nxp.com>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
Message-ID: <20181105084653.26597-6-xiaowei.bao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the layerscape EP device support in pci_endpoint_test driver.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - no change

 drivers/misc/pci_endpoint_test.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 896e2df..744d10c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -788,6 +788,8 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
+	/* 0x81c0: The device id of ls1046a in NXP. */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
 	{ }
 };
-- 
1.7.1
