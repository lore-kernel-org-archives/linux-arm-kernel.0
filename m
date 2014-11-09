From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 9 Nov 2014 19:28:00 +0100
Subject: [PATCH 0/2] of: Fix some 'const' problems
Message-ID: <cover.1415557680.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cast is often needed to call some OF functions, removing
the 'const' attribute.
This patchset makes 'const' the device node pointers of the functions
of_clk_get() and of_node_put() and also removes some useless casts
in the sound/soc tree.

Jean-Francois Moine (2):
  of: Make const the device node pointers in of_clk_get and of_node_put
  ASoC: Remove useless casts

 drivers/clk/clkdev.c                  | 2 +-
 drivers/of/dynamic.c                  | 2 +-
 include/linux/clk.h                   | 4 ++--
 include/linux/of.h                    | 4 ++--
 sound/soc/generic/simple-card.c       | 7 ++-----
 sound/soc/samsung/odroidx2_max98090.c | 4 ++--
 sound/soc/ux500/mop500.c              | 6 ++----
 7 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.1.3
