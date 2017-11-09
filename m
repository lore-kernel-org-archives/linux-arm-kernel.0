From: poza@codeaurora.org (Pawandeep Oza)
Date: Fri, 10 Nov 2017 02:16:36 +0530
Subject: [PATCH 1/4] PCI: Add port service list node for pci_dev.
In-Reply-To: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
References: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
Message-ID: <1510260399-14886-2-git-send-email-poza@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oza Pawandeep <poza@codeaurora.org>

This patch adds the list node to keep track of services registered to
pci port driver.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1..f772979 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1931,6 +1931,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 		return NULL;
 
 	INIT_LIST_HEAD(&dev->bus_list);
+	INIT_LIST_HEAD(&dev->service_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 96c9498..eb86a4b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -408,6 +408,8 @@ struct pci_dev {
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
 
+	struct list_head service_list;	/* node in per-service list */
+
 #ifdef CONFIG_PCIE_PTM
 	unsigned int	ptm_root:1;
 	unsigned int	ptm_enabled:1;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
