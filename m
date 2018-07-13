From: yibin.gong@nxp.com (Robin Gong)
Date: Fri, 13 Jul 2018 21:08:44 +0800
Subject: [PATCH v2 0/3] add memcpy support for sdma
Message-ID: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is to add memcpy interface for imx-sdma, besides,to
support dmatest and enable config by default, so that could test dma
easily without any other device support such as uart/audio/spi...

Change from v1:
  1. remove bus_width check for memcpy since only max bus width needed for
     memcpy case to speedup copy.
  2. remove DMATEST support patch, since DMATEST is a common memcpy case.
  3. split to single patch for SDMA_BD_MAX_CNT instead of '0xffff'
  4. move sdma_config_ownership() from alloc_chan into sdma_prep_memcpy.
  5. address some minor review comments.

Robin Gong (3):
  dmaengine: imx-sdma: add SDMA_BD_MAX_CNT to replace '0xffff'
  dmaengine: imx-sdma: add memcpy interface
  ARM: configs: imx_v6_v7_defconfig: add DMATEST support

 arch/arm/configs/imx_v6_v7_defconfig |   3 +-
 drivers/dma/imx-sdma.c               | 106 ++++++++++++++++++++++++++++++++---
 2 files changed, 99 insertions(+), 10 deletions(-)

-- 
2.7.4
