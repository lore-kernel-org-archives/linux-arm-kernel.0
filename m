From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Fri, 4 Aug 2017 09:32:24 +0800
Subject: [PATCH v3 0/4] Add larbid init routine for mediatek's gen1 smi larb
 driver
Message-ID: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Mediatek's gen1 smi need the hardware larb-id to identify the offset for
the register which controls whether enable iommu for this larb.
In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
the larbid was used without properly initialized. This patchset fixed
that.
Also include a patch which using the of_device_get_match_data helper to
simplify the code.
This patchset was base on 4.13-rc1.

Change since v2:
 - Using compatible strings of "mediatek,larb-id" instead of "mediatek,larbid"
   to make it a bit easier to read.
 - Put the v2 of the patch ("memory: mtk-smi: Use of_device_get_match_data helper")[1]
   in this patchset to make the changes easier for review.
 - Add the reivewer's tag in commit messages.

Change since v1:
 - Using mtk_smi_larb_gen to identify whether larbid was needed instead of
   checking hard code bindings.

[1] https://patchwork.kernel.org/patch/9864719

Honghui Zhang (4):
  memory: mtk-smi: Use of_device_get_match_data helper
  memory: mtk-smi: add larbid handle routine
  dt-bindings: mediatek: add descriptions for larbid
  arm: dts: mediatek: add larbid property for larb

 .../memory-controllers/mediatek,smi-larb.txt       | 15 +++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                      |  3 +++
 drivers/memory/mtk-smi.c                           | 26 ++++++++++++----------
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.6.4
