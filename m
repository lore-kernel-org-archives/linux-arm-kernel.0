From: poza@codeaurora.org (Pawandeep Oza)
Date: Fri, 10 Nov 2017 02:16:35 +0530
Subject: [PATCH 0/4] PCI: query active service list
Message-ID: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The list of patches provides querying facility to all services drivers.
They can query any other service, to see if it is active/registered.

This is useful when multiple service drivers do not want to race for 
actions based on service interrupt trigger.

for e.g. if both AER and DPC are triggering, AER should not race since
DPC is going to bring down the link and all the devices beneath, and 
goint to recover HW.

Oza Pawandeep (4):
  PCI: Add port service list node for pci_dev.
  PCI/portdrv: Add/Remove port services to the list
  PCI/portdrv: Implement interface to query the registered service
  PCI/AER: Dont do recovery when DPC is enabled

 drivers/pci/pcie/aer/aerdrv_core.c | 12 ++++++++++++
 drivers/pci/pcie/portdrv_core.c    | 29 +++++++++++++++++++++++++++++
 drivers/pci/probe.c                |  1 +
 include/linux/pci.h                |  2 ++
 include/linux/pcieport_if.h        |  3 ++-
 5 files changed, 46 insertions(+), 1 deletion(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
