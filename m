From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 23 Nov 2012 10:09:01 +0100
Subject: [RESEND PATCH v3 0/3] i2c: at91: add dma support
Message-ID: <1353661744-5703-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi Wolfram,

I've rebased the set of patches on 3.7-rc6. I hope you could apply them.

Regards

Ludovic

Changes:
- v3
    - introduce two new patches: one to fix a compilation warning and one to
    fix indentation
    - introduce a threshold to use dma transfers
    - use dma wrappers to clean code
    - remove dma cookie since it is no more used

- v2 (based on Russell feedback):
    - replace DMA_TO_DEVICE/DMA_FROM_DEVICE by DMA_MEM_TO_DEV/DMA_DEV_TO_MEM
    - don't check for tx_submit errors
    - atmel dma header location has changed


Ludovic Desroches (3):
  i2c: at91: fix compilation warning
  i2c: at91: change struct members indentation
  i2c: at91: add dma support

 drivers/i2c/busses/i2c-at91.c | 338 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 314 insertions(+), 24 deletions(-)

-- 
1.7.11.3
