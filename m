From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Tue,  1 Dec 2015 11:14:55 +0200
Subject: [PATCH 0/4] bam dma fixes and one dt extension
Message-ID: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are three bam dma fixes, which I made during testing qcrypto
driver. The first one is a real fix, the second one is related to
peripherals on which the BAM IP is initialized by remote execution
environment, and the third one is a sleeping bug IMO.

The last patch is a extension again for peripherals which BAM is
remotely controlled by other execution environment.

All patches has been tested on db410c board with apq8016.

Comments are welcome!

regards,
Stan

Stanimir Varbanov (4):
  dmaengine: qcom_bam_dma: fix dma free memory on remove
  dmaengine: qcom_bam_dma: clear BAM interrupt only if it is rised
  dmaengine: qcom_bam_dma: use correct pipe FIFO size
  dmaengine: qcom_bam_dma: add controlled remotely dt property

 .../devicetree/bindings/dma/qcom_bam_dma.txt       |    2 ++
 drivers/dma/qcom_bam_dma.c                         |   24 ++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.7.9.5
