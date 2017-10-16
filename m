From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 16 Oct 2017 15:07:37 +0800
Subject: [PATCH v5 0/7] Add PMIC support to MediaTek MT7622 SoC
Message-ID: <cover.1508135937.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v4:
- for patch 1/7 and 5/7, add the description about how to bind pmic wrapper with MT6380.
- for patch 3/7, add more comments explaining why additional pwrap_read is 
required in the pwrap_write32.
- for patch 4/7 and 5/7, refactoring pwrap_init would help the driver to be more extensible 
when more various SoC and PMICs join.
- for patch 6/7, change pwrap_mt7622 into a const struct.

Changes since v3
- rebase into Linux 4.14-rc1
- removed those patches already applied

Changes since v2:
- for patch 1/2, enhance the document as the suggestions from v2.
- for patch 3, constify the table with struct regulator_ops, also fix that
regulator doesn't have modesetting facilities it just shouldn't have the ops
and finally fix copy+paste mistake in warranty disclaimer.
- for patch 7/8, sort the things added for MT7622/MT6380 alphabetically.

Chenglin Xu (1):
  soc: mediatek: pwrap: add support for MT7622 SoC

Sean Wang (6):
  dt-bindings: arm: mediatek: add MT7622 string to the PMIC wrapper doc
  soc: mediatek: pwrap: add pwrap_read32 for reading in 32-bit mode
  soc: mediatek: pwrap: add pwrap_write32 for writing in 32-bit mode
  soc: mediatek: pwrap: refactor pwrap_init for the various PMIC types
  soc: mediatek: pwrap: add MediaTek MT6380 as one slave of pwrap
  soc: mediatek: pwrap: fixup warnings from coding style

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   6 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 461 ++++++++++++++++++---
 2 files changed, 407 insertions(+), 60 deletions(-)

-- 
2.7.4
