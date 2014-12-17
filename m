From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 17 Dec 2014 13:02:22 -0500
Subject: [RFC PATCH 0/2] PCI: get DMA configuration from parent device
Message-ID: <1418839344-14393-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone PCI devices requires the dma_pfn_offset to be set correctly
so that the PCI devices get the right DMA mask to function. This
patch adds a helper function to get this configuration from the root
bridge's parent device. The probe.c code now calls this helper to set
the default dma configuration if the parent device is dma capable.

Typically, dma-ranges are defined in the DT node of the SoC and gets
updated in the root bridge's parent device structure. My original
patch for this was at [1] which was NACK-ed and this is an attempt
to implement a better solution. This may have side effects that I am
unware of. So sending as a RFC patch to get feedback before sending
the formal patch. Please review and provide me the comment so that
I can incorporate the same.

[1] http://www.gossamer-threads.com/lists/linux/kernel/2024591

Murali Karicheri (2):
  common: dma-mapping: introduce dma_get_parent_cfg() helper
  PCI: get device dma configuration from parent

 drivers/base/dma-mapping.c  |   18 ++++++++++++++++++
 drivers/pci/probe.c         |   20 +++++++++++++++++---
 include/linux/dma-mapping.h |    3 +++
 3 files changed, 38 insertions(+), 3 deletions(-)

-- 
1.7.9.5
