From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 17:16:01 +0800
Subject: [PATCH 0/2] Add clk_null to be the dummy root of MT8173 clocks
Message-ID: <1436519763-3195-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.2-rc1 and adds a dummy clock "clk_null"
to be the root clock of clocks whose parents are not contained in
CCF clock tree.

In previous patch [1], it seems not suitable to declare clk_null in
device tree because it's not a clock comes form outside of SoC. So we
move clk_null into clock driver.

[1] https://lkml.org/lkml/2015/6/18/24

James Liao (2):
  clk: mediatek: Add root clocks support for Mediatek SoC.
  clk: mediatek: Add clk_null to be the dummy root clock for MT8173

 drivers/clk/mediatek/clk-mt8173.c      |  5 +++++
 drivers/clk/mediatek/clk-mtk.c         | 23 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h         | 17 ++++++++++++++++-
 include/dt-bindings/clock/mt8173-clk.h |  1 +
 4 files changed, 45 insertions(+), 1 deletion(-)

--
1.8.1.1.dirty
