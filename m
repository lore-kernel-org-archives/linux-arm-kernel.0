From: poza@codeaurora.org (Oza Pawandeep)
Date: Wed, 15 Nov 2017 10:26:44 +0530
Subject: [PATCH v2 0/4] PCI: query active service list
Message-ID: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The list of patches provides querying facility to all services drivers.
They can query any other service, to see if it is active/registered.

This is useful when multiple service drivers do not want to race for
actions based on service interrupt trigger.

for e.g. if both AER and DPC are triggering, AER should not race since
DPC is going to bring down the link and all the devices beneath, and
going to recover HW.

Another example;
If hot plug service is not active DPC can do enumeration.

Changes Since v1:
Sinan's comment implemented.

Oza Pawandeep (4):
  PCI: Add port service list node for pci_dev.
  PCI/portdrv: Add/Remove port services to the list
  PCI/portdrv: Implement interface to query the registered service
  PCI/AER: Dont do recovery when DPC is enabled

 drivers/pci/pcie/aer/aerdrv_core.c | 33 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv_core.c    | 39 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                |  1 +
 include/linux/pci.h                |  2 ++
 include/linux/pcieport_if.h        |  4 +++-
 5 files changed, 78 insertions(+), 1 deletion(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
