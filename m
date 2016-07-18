From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 18 Jul 2016 14:39:27 -0400
Subject: [PATCH 00/10] dmaengine: qcom_hidma: add MSI interrupt support
Message-ID: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new version of the HW supports MSI interrupts instead of wired
interrupts. The MSI interrupts are especially useful for the guest machine execution.
The wired interrupts usually trap to the hypervisor and then are relayed to the
actual interrupt.

The MSI interrupts can be directly fed into the interrupt controller.

Adding a new OF compatible string (qcom,hidma-1.1) and ACPI string
(QCOM8062) to distinguish newer HW from the older ones.


Sinan Kaya (10):
  Documentation: DT: qcom_hidma: update binding for MSI
  Documentation: DT: qcom_hidma: correct spelling mistakes
  of: irq: make of_msi_configure accessible from modules
  dmaending: qcom_hidma: configure DMA and MSI for OF
  dmaengine: qcom_hidma: make pending_tre_count atomic
  dmaengine: qcom_hidma: make error and success path common
  dmaengine: qcom_hidma: eliminate processed variables
  dmaengine: qcom_hidma: bring out interrupt cause
  dmaengine: qcom_hidma: add a common API to setup the interrupt
  dmaengine: qcom_hidma: add MSI support for interrupts

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |   7 +-
 drivers/dma/qcom/hidma.c                           | 128 ++++++++++++++-
 drivers/dma/qcom/hidma.h                           |  11 +-
 drivers/dma/qcom/hidma_dbg.c                       |   9 +-
 drivers/dma/qcom/hidma_ll.c                        | 173 ++++++++++-----------
 drivers/dma/qcom/hidma_mgmt.c                      |   4 +-
 drivers/of/irq.c                                   |   1 +
 7 files changed, 226 insertions(+), 107 deletions(-)

-- 
1.8.2.1
