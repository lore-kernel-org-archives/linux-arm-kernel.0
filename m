From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Feb 2017 15:31:13 +0100
Subject: [PATCH v3 0/3] pci: remove msi_controller registration API
Message-ID: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small patch series aims at removing the small msi_controller
registration API implemented in drivers/of/of_pci.c.

In order to do so, it moves the last two users of this API to the
generic MSI support:

 - The pci-aardvark driver is moved to use the generic MSI
   support. This driver is both the provider of the MSI capability and
   the consumer of this capability.

 - The pci-mvebu driver is cleaned up from using the msi_controller
   registration API. This driver is only consuming MSI capabilies from
   another driver (irq-armada-370-xp) which was migrated to the
   generic MSI support some time ago. Therefore, this patch is simply
   removing dead code.

Finally, the last commit removed the now unused API.

Changes between v2 and v3 are described in each individual patch.

Thanks,

Thomas

Thomas Petazzoni (3):
  pci: pci-aardvark: move to MSI handling using generic MSI support
  pci: pci-mvebu: remove useless MSI enabling code
  of: pci: remove unused MSI controller helpers

 drivers/of/of_pci.c             |  45 -----------
 drivers/pci/host/pci-aardvark.c | 173 ++++++++++++++++------------------------
 drivers/pci/host/pci-mvebu.c    |  17 ----
 include/linux/of_pci.h          |  11 ---
 4 files changed, 67 insertions(+), 179 deletions(-)

-- 
2.7.4
