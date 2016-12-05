From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 5 Dec 2016 05:22:20 +0000
Subject: [PATCH 0/3] clkdev: add devm_get_clk_from_child()
Message-ID: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen

This is v5 of "clkdev: add devm_of_clk_get()", but new series.
I hope my understanding was correct with your idea.

Kuninori Morimoto (3):
  1) clkdev: add devm_get_clk_from_child()
  2) ASoC: simple-card: use devm_get_clk_from_child()
  3) ASoC: simple-card-utils: enable clocks/clock-names/clock-ranges

 .../devicetree/bindings/sound/simple-card.txt      | 32 +++++++++++++++
 drivers/clk/clk-devres.c                           | 21 ++++++++++
 include/linux/clk.h                                | 29 ++++++++++++--
 include/sound/simple_card_utils.h                  | 11 +++---
 sound/soc/generic/simple-card-utils.c              | 45 ++++++++++++++++++++--
 sound/soc/generic/simple-card.c                    |  4 +-
 sound/soc/generic/simple-scu-card.c                |  4 +-
 7 files changed, 129 insertions(+), 17 deletions(-)

-- 
1.9.1
