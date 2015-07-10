From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 16:39:31 +0800
Subject: [PATCH v3 0/3] Fixes for MT8173 PLLs
Message-ID: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Title changed. Previous title is "Add MT8173 MMPLL change rate support"
and can be found in [1].

This patchset contains some fixes for changing rate of PLLs, especially
for MMPLL.

The first 2 patches are common fixes for PLLs, and the last patch is a
fix to support MT8173 MMPLL changing rate because its frequency setting
is different from other PLLs.

changes since v2:
- Rebase to 4.2-rc1.
- Split fixes of PLL setting calculation to a separeted patch.

changes since v1:
- Add a separated patch for mtk_pll_set_rate_regs().
- Use a structure array to describe a div_table.
- Limit max frequency to div_table[0].
- Minor changes such as static and comments.

[1] https://lkml.org/lkml/2015/7/8/265

James Liao (3):
  clk: mediatek: Fix PLL registers setting flow
  clk: mediatek: Fix calculation of PLL rate settings
  clk: mediatek: Add MT8173 MMPLL change rate support

 drivers/clk/mediatek/clk-mt8173.c | 24 +++++++++++++++++++++---
 drivers/clk/mediatek/clk-mtk.h    |  6 ++++++
 drivers/clk/mediatek/clk-pll.c    | 39 +++++++++++++++++++++++++++------------
 3 files changed, 54 insertions(+), 15 deletions(-)

--
1.8.1.1.dirty
