From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Thu, 27 Jul 2017 10:01:09 +0800
Subject: [PATCH 0/3] Add larbid init routine for mediatek's gen1 smi larb
 driver
Message-ID: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Mediatek's gen1 smi need the hardware larbid to identify the offset for
the register which controls whether enable iommu for this larb.
In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
the larbid was used without properly initialized. This patchset fixed
that.

Honghui Zhang (3):
  memory: mtk-smi: add larbid init routine
  dt-bindings: mediatek: add descriptions for larbid
  arm: dts: mediatek: add larbid property for larb

 .../bindings/memory-controllers/mediatek,smi-larb.txt     | 15 +++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                             |  3 +++
 drivers/memory/mtk-smi.c                                  |  9 +++++++++
 3 files changed, 27 insertions(+)

-- 
2.6.4
