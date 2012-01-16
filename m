From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Jan 2012 15:20:28 +0530
Subject: [PATCH 0/9] dmaengine: Pl08x and dw_dmac updates
Message-ID: <cover.1326707233.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod/Dan,

This patchset does following:
- Adds DMA_SLAVE_CONFIG for dw_dmac driver
- Adds device_fc (device flow control) field in struct DMA_SLAVE_CONFIG
- Updates pl08x driver according to that
- Fixes few issues/bugs in dw_dmac driver
- Includes earlier patchset sent by Rajeev for cleanly applying this patchset

Rajeev KUMAR (1):
  dmaengine/dw_dmac: Hibernation support in dw_dmac

Viresh Kumar (7):
  dmaengine: Add flow controller information to dma_slave_config
  dmaengine/amba-pl08x: Take flow controller info from DMA_SLAVE_CONFIG
  dmaengine/dw_dmac: Don't use magic number for total number of
    channels
  dmaengine/dw_dmac: Use platform_get_drvdata instead of accessing dev
    directly
  dmaengine/dw_dmac: Don't handle block interrupts
  dmaengine/dw_dmac: Unmap all memory buffers after completion of slave
    transfers
  dmaengine/dw_dmac: Add support for DMA_SLAVE_CONFIG

 drivers/dma/amba-pl08x.c   |    4 +-
 drivers/dma/dw_dmac.c      |  171 ++++++++++++++++++++++++++------------------
 drivers/dma/dw_dmac_regs.h |    3 +
 include/linux/amba/pl08x.h |    8 +-
 include/linux/dmaengine.h  |    5 ++
 include/linux/dw_dmac.h    |    6 --
 6 files changed, 115 insertions(+), 82 deletions(-)

-- 
1.7.8.110.g4cb5d
