From: tixy@linaro.org (Jon Medhurst)
Date: Fri,  7 Nov 2014 18:05:16 +0000
Subject: [PATCH 0/2] dma: pl330: Fixes for DMA memcpy
Message-ID: <1415383518-29327-1-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a couple of patches I produced when trying to get dmatest to run
with the pl330 driver. The second one is actually a theoretical fix
because the FIFO on the platform I was using is too large for the tests
to hit the limit, but the datasheet says the device can lockup if all
the FIFO entries are exhausted, so it seems like a sensible precaution.

Jon Medhurst (2):
      dma: pl330: Align DMA memcpy operations to MFIFO width
      dma: pl330: Limit MFIFO usage for memcpy to avoid exhausting entries

 drivers/dma/pl330.c | 16 ++++++++++++++--
