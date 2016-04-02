From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 2 Apr 2016 11:49:13 +0200
Subject: [PATCH v4 0/3] dmaengine: sun6i: Upgrade for audio transfers
Message-ID: <cover.1459590553.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains most of the required changes to
the sun6i DMA driver for audio streaming (tested in
a Allwinner H3 - Orange PI 2).
It is based on the previous series 'dmaengine: sun6i: Fixes'
(2016-03-18).
The lacking patch (Add 4 as a possible burst value for H3) will be
submitted when a consensus with Maxime Ripard will be found.

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
  dmaengine: sun6i: Simplify lli setting
  dmaengine: sun6i: Set default maxburst size and bus width
  dmaengine: sun6i: Add cyclic capability

 drivers/dma/sun6i-dma.c | 246 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 184 insertions(+), 62 deletions(-)

-- 
2.8.0
