From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Fri, 28 Jul 2017 18:55:40 +0800
Subject: [PATCH v2 0/3] Add larbid init routine for mediatek's gen1 smi larb
 driver
Message-ID: <1501239343-9190-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Mediatek's gen1 smi need the hardware larbid to identify the offset for
the register which controls whether enable iommu for this larb.
In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
the larbid was used without properly initialized. This patchset fixed
that.
This patchset was based on the v2 version of the patch:
memory: mtk-smi: Use of_device_get_match_data helper[1],
which was base on 4.13-rc1

[1] https://patchwork.kernel.org/patch/9864719

Change since v1:
 - Using mtk_smi_larb_gen to identify whether larbid was needed instead of
   checking hard code bindings.

Honghui Zhang (3):
  memory: mtk-smi: add larbid handle routine
  dt-bindings: mediatek: add descriptions for larbid
  arm: dts: mediatek: add larbid property for larb

 .../bindings/memory-controllers/mediatek,smi-larb.txt     | 15 +++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                             |  3 +++
 drivers/memory/mtk-smi.c                                  | 12 ++++++++++++
 3 files changed, 30 insertions(+)

-- 
2.6.4
