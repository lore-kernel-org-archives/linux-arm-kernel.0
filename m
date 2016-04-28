From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 28 Apr 2016 17:19:11 +0200
Subject: [PATCH v6 0/3] dmaengine: sun6i: Upgrade for audio transfers
Message-ID: <cover.1461856751.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains most of the remaining changes to
the sun6i DMA driver for audio streaming (tested in
a Allwinner H3 - Orange PI 2).
The lacking patch (Add 4 as a possible burst value for H3) will be
submitted when a consensus with Maxime Ripard will be found.
This series is based on the previous patches applied by Vinod Koul.

v6
 - check the transfer direction in all cases (Vinod Koul)
 - a new patch about useless check has been added
 - the applied patch has been removed from this series
v5
 - fix checkpatch error (Vinod Koul)
v4
 - remove 'Add 4 as a possible burst value for H3'
	(no consensus yet)
 - remove 'Simplify some macros' (Maxime Ripard)
 - remove 'Compact a bit some config constants' (not critical)
 - split 'lli setting' into 'simplify' and 'default burst and bus width'
	(Maxime Ripard)
v3
 - do some optimizations
 - add a check about the maxburst value '4' (Maxime Ripard)
 - remove the driver fixes
v2 (comments from Vinod Koul and Sergei Shtylyov - thanks)
 - typo fixes
 - change some comments
 - better handling of burst and bus width
 - remove useless code in the cyclic capability patch

Jean-Francois Moine (3):
  dmaengine: sun6i: Set default maxburst size and bus width
  dmaengine: sun6i: Remove useless check
  dmaengine: sun6i: Add cyclic capability

 drivers/dma/sun6i-dma.c | 162 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 146 insertions(+), 16 deletions(-)

-- 
2.8.1
