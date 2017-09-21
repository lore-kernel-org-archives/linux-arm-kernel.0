From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 21 Sep 2017 16:26:50 +0800
Subject: [PATCH v4 0/7] Add PMIC support to MediaTek MT7622 SoC
Message-ID: <cover.1505980364.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

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
  soc: mediatek: pwrap: update pwrap_init without slave programming
  soc: mediatek: pwrap: add MediaTek MT6380 as one slave of pwrap
  soc: mediatek: pwrap: fixup warnings from coding style

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 417 ++++++++++++++++++---
 2 files changed, 362 insertions(+), 56 deletions(-)

-- 
2.7.4
