From: agross@codeaurora.org (Andy Gross)
Date: Wed,  7 Jan 2015 21:26:10 -0600
Subject: [Patch v2 0/2] Add Qualcomm ADM dmaengine driver
Message-ID: <1420687572-7116-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces the dmaengine driver for the Qualcomm Application
Data Mover (ADM) DMA controller present on MSM8960, APQ8064, and IPQ8064
devices.

The initial version of this driver will only support slave DMA operations
between system memory and peripherals.  Flow control via the CRCI (client rate
control interface) is supported and can be configured via device tree
configuration.  Flow control usage is required for some peripheral devices.

Changes since v1:
  - Fixed various review comments
  - Fixed some descriptor programming issues.
  - Added single descriptors to support sub burst length transactions.
    Selection of single or box descriptors depends on the sg length and burst
    size.
  - Removed use of crci in the dmas property.  CRCI is now designated via the
    slave_config structure and will be stored in slave_id.

Andy Gross (2):
  dmaengine: Add ADM driveri
  dt/bindings: qcom_adm: Fix channel specificers

 Documentation/devicetree/bindings/dma/qcom_adm.txt |   14 +-
 drivers/dma/Kconfig                                |   10 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/qcom_adm.c                             |  899 ++++++++++++++++++++
 4 files changed, 915 insertions(+), 9 deletions(-)
 create mode 100644 drivers/dma/qcom_adm.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
