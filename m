From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 24 Dec 2014 17:11:37 -0500
Subject: [PATCH v2 0/2] PCI: get DMA configuration from parent device
Message-ID: <1419459099-6667-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI devices on Keystone doesn't have correct dma_pfn_offset set. This patch
add capability to set the dma configuration such as dma-mask, dma_pfn_offset,
and dma ops etc using the information from DT. The prior RFCs and discussions
are available at [1] and [2] below.

[2] : https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg790244.html
[1] : http://www.gossamer-threads.com/lists/linux/kernel/2024591

Change history:
	v2 - update size to coherent_dma_mask + 1 if dma-range info is missing
	   - also check the np for null.
	v1 - updates based on the comments against initial RFC.
	   - Added a helper function to get the OF node of the parent
	   - Added an API in of_pci.c to update DMA configuration of the pci
	     device.

Murali Karicheri (2):
  of/pci: add of_pci_dma_configure() update dma configuration
  PCI: update dma configuration from DT

 drivers/of/of_pci.c    |   73 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c    |    2 ++
 include/linux/of_pci.h |   12 ++++++++
 3 files changed, 87 insertions(+)

-- 
1.7.9.5
