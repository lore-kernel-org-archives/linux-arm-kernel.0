From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 16 Jan 2017 19:44:53 +0100
Subject: [PATCH v2 0/3] spi: pca2xx: Prepare for and enable MSI support
Message-ID: <cover.1484592296.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enhances the pca2xx driver's interrupt handler with support for
edge-triggered interrupts and makes use of that for PCI-hosted variants,
like the Intel Quark SoC.

Changes in v2:
- factored out handle_bad_msg (Andy)
- reordered code in patch 3, avoiding unneeded pci_free_irq_vectors (Andy)

Jan

Jan Kiszka (3):
  spi: pxa2xx: Factor out handle_bad_msg
  spi: pxa2xx: Prepare for edge-triggered interrupts
  spi: pca2xx-pci: Allow MSI

 drivers/spi/spi-pxa2xx-pci.c |  8 ++++++-
 drivers/spi/spi-pxa2xx.c     | 51 +++++++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 23 deletions(-)

-- 
2.1.4
