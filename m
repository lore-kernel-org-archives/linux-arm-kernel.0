From: agross@codeaurora.org (Andy Gross)
Date: Fri, 10 Jan 2014 13:07:52 -0600
Subject: [PATCH v2 0/2] Add Qualcomm BAM dmaengine driver
Message-ID: <1389380874-22753-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces the dmaengine driver for the Qualcomm Bus Access
Manager (BAM) DMA controller present on MSM 8x74 devices.  A number of the
on-chip devices have their own BAM DMA controller and use it to move data
between system memory and peripherals or between two peripherals.

The initial version of this driver will only support slave DMA operations
between system memory and peripherals.

Changes from v1:
        - Converted driver to use virt-dma
        - Reworked probe function per review comments
        - tx_status function now computes and returns residuals
        - Removed proprietary slave config.  Removed associated include file.
        - Renamed files to reflect vendor name instead of specific device
	- Converted to use (readl|writel)_relaxed w/ appropriate barriers
	- Removed unions in favor of standard types.

Andy Gross (2):
  dmaengine: add Qualcomm BAM dma driver
  dmaengine: qcom_bam_dma: Add device tree binding

 .../devicetree/bindings/dma/qcom_bam_dma.txt       |  52 ++
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/qcom_bam_dma.c                         | 843 +++++++++++++++++++++
 drivers/dma/qcom_bam_dma.h                         | 268 +++++++
 5 files changed, 1173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
 create mode 100644 drivers/dma/qcom_bam_dma.c
 create mode 100644 drivers/dma/qcom_bam_dma.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
