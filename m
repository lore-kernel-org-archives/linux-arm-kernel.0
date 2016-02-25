From: rrichter@caviumnetworks.com (Robert Richter)
Date: Thu, 25 Feb 2016 12:02:42 +0100
Subject: [PATCH 0/2] arm64, cma,
 gicv3-its: Use CMA for allocation of large device tables
Message-ID: <1456398164-16864-1-git-send-email-rrichter@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This series implements the use of CMA for allocation of large device
tables for the arm64 gicv3 interrupt controller.

There are 2 patches, the first is for early activation of cma, which
needs to be done before interrupt initialization to make it available
to the gicv3. The second implements the use of CMA to allocate
gicv3-its device tables.

This solves the problem where mem allocation is limited to 4MB. A
previous patch sent to the list to address this that instead increases
FORCE_MAX_ZONEORDER becomes obsolete.

Robert Richter (2):
  mm: cma: arm64: Introduce dma_activate_contiguous() for early
    activation
  irqchip, gicv3-its, cma: Use CMA for allocation of large device tables

 arch/arm64/kernel/irq.c          |  4 ++++
 drivers/base/dma-contiguous.c    | 14 ++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c | 30 +++++++++++++++++++++---------
 include/linux/cma.h              |  1 +
 include/linux/dma-contiguous.h   |  8 ++++++++
 mm/cma.c                         |  6 +++++-
 6 files changed, 53 insertions(+), 10 deletions(-)

-- 
2.7.0.rc3
