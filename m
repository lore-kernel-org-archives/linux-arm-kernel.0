From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 19 Apr 2011 14:02:05 +0530
Subject: [PATCH V2 0/7] dmaengine/dw_dmac updates
Message-ID: <cover.1303194835.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes few issues and extends its support.

Changes in V2:
 - lflags added in dw_dma_chan instead of dw_dma
 - Patch from Linus Walleij added for pause and resume functionality.

Linus Walleij (1):
  dmaengine/dw_dmac: implement pause and resume in dwc_control

Viresh Kumar (6):
  dmaengine/dw_dmac: Replace spin_lock_bh with irqsave variants
  dmaengine/dw_dmac: Enable resubmission from callback routine.
  dmaengine/dw_dmac: call dwc_descriptor_complete from dwc_control with
    lock held
  dmaengine/dw_dmac: don't call callback routine in case
    dmaengine_terminate_all() is called
  dmaengine/dw_dmac: set residue as total len in dwc_tx_status if
    status is !DMA_SUCCESS
  dmaengine/dw_dmac: Divide one sg to many desc, if sg len is greater
    than DWC_MAX_COUNT

 drivers/dma/dw_dmac.c      |  179 ++++++++++++++++++++++++++++----------------
 drivers/dma/dw_dmac_regs.h |    2 +
 2 files changed, 117 insertions(+), 64 deletions(-)

-- 
1.7.2.2
