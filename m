From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Tue, 23 May 2017 11:24:08 +0800
Subject: [PATCH v4 0/3] Fix mdp device tree 
Message-ID: <1495509851-29159-1-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
- Add backwards compability if dts is out-of-date

Changes in v3:
- Upload patches again because forget to add v2 in title

Changes in v2:
- Update commit message

If the mdp_* nodes are under an mdp sub-node, their corresponding
platform device does not automatically get its iommu assigned properly.

Fix this by moving the mdp component nodes up a level such that they are
siblings of mdp and all other SoC subsystems.  This also simplifies the
device tree.

Although it fixes iommu assignment issue, it also break compatibility
with old device tree. So, the patch in driver is needed to iterate over
sibling mdp device nodes, not child ones, to keep driver work properly.

Daniel Kurtz (2):
  arm64: dts: mt8173: Fix mdp device tree
  media: mtk-mdp: Fix mdp device tree

Minghsiu Tsai (1):
  dt-bindings: mt8173: Fix mdp device tree

 .../devicetree/bindings/media/mediatek-mdp.txt     |  12 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 126 ++++++++++-----------
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |  12 +-
 3 files changed, 73 insertions(+), 77 deletions(-)

-- 
1.9.1
