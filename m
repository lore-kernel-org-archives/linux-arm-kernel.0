From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 11 Mar 2016 12:19:29 +0100
Subject: [PATCH v2 0/5] dmaengine: sun6i: Fixes and upgrade for audio transfers
Message-ID: <cover.1457695169.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains the required fixes and changes to the sun6i
DMA driver for audio streaming.
These ones have been tested in a Allwinner H3 (Orange PI 2).

Changes since v1 (comments from Vinod Koul and Sergei Shtylyov - thanks)
- typo fixes
- change some comments
- better handling of burst and bus width
- remove useless code in the cyclic capability patch

Jean-Francois Moine (5):
  dmaengine: sun6i: Fix the access of the IRQ register
  dmaengine: sun6i: Fix impossible settings of burst and bus width
  dmaengine: sun6i: Add 4 as a possible burst value
  dmaengine: sun6i: Set system values to memory burst and bus width
  dmaengine: sun6i: Add cyclic capability

 drivers/dma/sun6i-dma.c | 160 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 146 insertions(+), 14 deletions(-)

-- 
2.7.3
