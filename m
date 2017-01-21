From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Sat, 21 Jan 2017 10:06:37 +0100
Subject: [PATCH v3 0/2] spi: pca2xx: Prepare for and enable MSI support
Message-ID: <cover.1484989599.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enhances the pca2xx driver's interrupt handler with support for
edge-triggered interrupts and makes use of that for PCI-hosted variants,
like the Intel Quark SoC.

Changes in v3:
- removed already applied patch "Factor out handle_bad_msg"
- avoid inner looping by making the hardware retrigger on "forgotten"
  IRQ sources
- added acked/reviewed tags

Changes in v2:
- factored out handle_bad_msg (Andy)
- reordered code in patch 3, avoiding unneeded pci_free_irq_vectors (Andy)

Jan

Jan Kiszka (2):
  spi: pxa2xx: Prepare for edge-triggered interrupts
  spi: pca2xx-pci: Allow MSI

 drivers/spi/spi-pxa2xx-pci.c | 8 +++++++-
 drivers/spi/spi-pxa2xx.c     | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.1.4
