From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 8 Jul 2015 16:37:44 +0800
Subject: [PATCH 0/2] Add MT8173 MMPLL change rate support
Message-ID: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 MMPLL frequency settings are different from common PLLs.
It needs different post divider settings for some ranges of frequency.
This patch add support for MT8173 MMPLL frequency setting, includes:

1. Add div-rate table for PLLs.
2. Increase the max ost divider setting from 3 (/8) to 4 (/16).
3. Write postdiv and pcw settings at the same time.

James Liao (2):
  clk: mediatek: Fix PLL registers setting flow
  clk: mediatek: Add MT8173 MMPLL change rate support

 drivers/clk/mediatek/clk-mt8173.c | 24 +++++++++++++++++++++---
 drivers/clk/mediatek/clk-mtk.h    |  6 ++++++
 drivers/clk/mediatek/clk-pll.c    | 39 +++++++++++++++++++++++++++------------
 3 files changed, 54 insertions(+), 15 deletions(-)

--
1.8.1.1.dirty
