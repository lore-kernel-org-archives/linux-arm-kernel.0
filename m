From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue,  2 Jan 2018 12:00:17 -0500
Subject: [PATCH V3 0/6] PCI: handle CRS response following Hot Reset and
 D3hot->D0
Message-ID: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rev 3.1 Sec 2.3.1 Request Handling Rules:
Valid reset conditions after which a device is permitted to return CRS
are:
* Cold, Warm, and Hot Resets,
* FLR
* A reset initiated in response to a D3hot to D0 uninitialized

Try to reuse FLR implementation towards other reset types.

Changes from v2:
* Correct Conventional PCI spec reference for AF_FLR
* Commit message update to capitilize the first word following colon

Sinan Kaya (6):
  PCI: Protect restore with device lock to be consistent
  PCI: Handle FLR failure and allow other reset types
  PCI: Make pci_flr_wait() generic and rename to pci_dev_wait()
  PCI: Wait device ready after pci_pm_reset()
  PCI: Add a return type for pci_reset_bridge_secondary_bus()
  PCI: Add device wait after slot and bus reset

 drivers/pci/pci.c   | 70 ++++++++++++++++++++++++++++++++++-------------------
 include/linux/pci.h |  4 +--
 2 files changed, 47 insertions(+), 27 deletions(-)

-- 
1.9.1
