From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 7 Oct 2015 17:14:38 +0800
Subject: [PATCH v2 0/3] Fix random hang up issue while kernel init
Message-ID: <1444209281-25536-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on v4.3-rc4, to fix system hanging up issue
while disabling unused clocks.

There is nothing different in mtk-scpsys.c and mt8173.dtsi from v1 [1].

Changes since v1:
- Rebase to v4.3-rc4.
- Add a patch to change the corresponding binding document.
- Add a separated patch to change the dtsi.

[1] https://patchwork.kernel.org/patch/7262411/

James Liao (3):
  dt-bindings: soc: Add clocks for Mediatek SCPSYS unit
  soc: mediatek: Fix random hang up issue while kernel init
  arm64: dts: mt8173: Add clocks for SCPSYS unit

 .../devicetree/bindings/soc/mediatek/scpsys.txt    | 10 ++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  6 +-
 drivers/soc/mediatek/mtk-scpsys.c                  | 67 ++++++++++++++--------
 3 files changed, 54 insertions(+), 29 deletions(-)

--
1.9.1
