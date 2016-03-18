From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Mar 2016 15:32:20 +0100
Subject: [PATCH v3 0/5] dmaengine: sun6i: Upgrade for audio transfers
Message-ID: <cover.1458311540.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series replaces the 2nd part of the previous series
'dmaengine: sun6i: Fixes and upgrade for audio transfers'.
It contains the required changes to the sun6i DMA driver for
audio streaming.
These ones have been tested in a Allwinner H3 (Orange PI 2).

Changes since v2
- do some optimizations
- add a check about the maxburst value '4' (Maxime Ripard)
- remove the driver fixes
Changes since v1 (comments from Vinod Koul and Sergei Shtylyov - thanks)
- typo fixes
- change some comments
- better handling of burst and bus width
- remove useless code in the cyclic capability patch

Jean-Francois Moine (5):
  dmaengine: sun6i: Simplify and fix lli setting
  dmaengine: sun6i: Add 4 as a possible burst value for H3
  dmaengine: sun6i: Add cyclic capability
  dmaengine: sun6i: Simplify some macros
  dmaengine: sun6i: Compact a bit some config constants

 drivers/dma/sun6i-dma.c | 264 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 197 insertions(+), 67 deletions(-)

-- 
2.7.4
