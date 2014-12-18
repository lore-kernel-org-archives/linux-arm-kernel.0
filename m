From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 18 Dec 2014 17:07:03 -0500
Subject: [RFC v1 PATCH 0/2] PCI: get DMA configuration from parent device
Message-ID: <1418940425-2017-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI devices on Keystone doesn't have correct dma_pfn_offset set. This patch
add capability to set the dma configuration such as dma-mask, dma_pfn_offset,
and dma ops etc using the same information from DT. The prior RFCs and
discussions are available at [1] and [2] below.

This patch make use of a recent dma API addeded to latest master and I could
only compile this as the latest kernel doesn't boot up on Keystone platforms.
So I am continue to send RFC version so that this gets a wider review before
sending the formal patch.

[2] : https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg790244.html
[1] : http://www.gossamer-threads.com/lists/linux/kernel/2024591

Change history:
	v1 - updates based on the comments against initial RFC.
	   - Added a helper function to get the OF node of the parent
	   - Added an API in of_pci.c to update DMA configuration of the pci
	     device.

Murali Karicheri (2):
  of/pci: add of_pci_dma_configure() update dma configuration
  PCI: update dma configuration from DT

 drivers/of/of_pci.c    |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c    |    2 ++
 include/linux/of_pci.h |   12 ++++++++
 3 files changed, 85 insertions(+)

-- 
1.7.9.5
