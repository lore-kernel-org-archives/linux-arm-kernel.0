From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 17:13:31 +0200
Subject: [PATCH 0/6] dma: mmp_pdma: fly-by transfers and external DMA requests
 support
Message-ID: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds support for fly-by transfers and external DMA requests to
the mmp_pdma driver. It's broken out as

- extending the dma_slave_config structure with a fly-by flag (1/6)
- miscellaneous small fixes and cleanups (2/6 to 4/6)
- fly-by transfer support (5/6)
- external DMA requests support (6/6)

I haven't been able to test the DT-related changes as my only PXA platform is
a PXA270 that doesn't boot through DT yet.

Laurent Pinchart (6):
  dmaengine: Add fly-by transfer flag to slave configuration structure
  dma: mmp_pdma: Fix the #dma-channels DT property documentation
  dma: mmp_pdma: Simplify access to channel drcmr value
  dma: mmp_pdma: Fix physical channel memory allocation size
  dma: mmp_pdma: Add support for fly-by transfers
  dma: mmp_pdma: Add support externel DMA requests

 Documentation/devicetree/bindings/dma/mmp-dma.txt |  13 ++-
 drivers/dma/mmp_pdma.c                            | 110 ++++++++++++++++++----
 include/linux/dmaengine.h                         |  13 +++
 include/linux/platform_data/mmp_dma.h             |   2 +
 4 files changed, 116 insertions(+), 22 deletions(-)

-- 
Regards,

Laurent Pinchart
