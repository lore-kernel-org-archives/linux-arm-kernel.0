From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 May 2017 11:57:43 +0200
Subject: [PATCH 00/10] dma: mv_xor_v2: fixes and improvements
Message-ID: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series brings a number of fixes (first 7 patches) and
improvements (last 3 patches) to the driver used for the Marvell XORv2
engine used in Marvell Armada 7K/8K.

Thanks,

Thomas

Hanna Hawa (4):
  dma: mv_xor_v2: enable XOR engine after its configuration
  dma: mv_xor_v2: implement proper interrupt coalescing
  dma: mv_xor_v2: remove unnecessary write to DESQ_STOP register
  dma: mv_xor_v2: add support for suspend/resume

Thomas Petazzoni (6):
  dma: mv_xor_v2: handle mv_xor_v2_prep_sw_desc() error properly
  dma: mv_xor_v2: properly handle wrapping in the array of HW
    descriptors
  dma: mv_xor_v2: do not use descriptors not acked by async_tx
  dma: mv_xor_v2: fix tx_submit() implementation
  dma: mv_xor_v2: remove interrupt coalescing
  dma: mv_xor_v2: set DMA mask to 40 bits

 drivers/dma/mv_xor_v2.c | 147 ++++++++++++++++++++++++++++++------------------
 1 file changed, 91 insertions(+), 56 deletions(-)

-- 
2.7.4
