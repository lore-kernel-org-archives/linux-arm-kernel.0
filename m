From: agross@codeaurora.org (Andy Gross)
Date: Thu, 26 Jun 2014 15:30:14 -0500
Subject: [PATCH 0/2] Add Qualcomm ADM dmaengine driver
Message-ID: <1403814616-23917-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces the dmaengine driver for the Qualcomm Application
Data Mover (ADM) DMA controller present on MSM8960, APQ8064, and IPQ8064
devices.

The initial version of this driver will only support slave DMA operations
between system memory and peripherals.  Flow control via the CRCI (client rate
control interface) is supported and can be configured via device tree
configuration.  Flow control usage is required for some peripheral devices.

Andy Gross (2):
  dmaengine: Add QCOM ADM DMA driver
  dmaengine: qcom_adm: Add device tree binding

 Documentation/devicetree/bindings/dma/qcom_adm.txt |   60 ++
 drivers/dma/Kconfig                                |   10 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/qcom_adm.c                             |  872 ++++++++++++++++++++
 4 files changed, 943 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt
 create mode 100644 drivers/dma/qcom_adm.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
