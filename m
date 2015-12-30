From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 30 Dec 2015 14:41:42 +0800
Subject: [PATCH 0/4] Mediatek MT2701 SCPSYS power domain support 
Message-ID: <1451457706-14798-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.4-rc7, add scpsys power domain support for
Mediatek MT2701/MT7623.

This patchset also separate MT8173 scpsys driver into common part
(mtk-scpsys.c) and platform part (mtk-scpsys-mt8173.c), so that MT2701
scpsys driver can share most implementation with MT8173.

James Liao (2):
  soc: mediatek: Separate scpsys driver common code
  soc: mediatek: Init MT8173 scpsys driver earlier

Shunli Wang (2):
  soc: mediatek: Add MT2701 power dt-bindings
  soc: mediatek: Add MT2701/MT7623 scpsys driver

 drivers/soc/mediatek/Kconfig             |  24 ++-
 drivers/soc/mediatek/Makefile            |   2 +
 drivers/soc/mediatek/mtk-scpsys-mt2701.c | 161 +++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys-mt8173.c | 190 +++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c        | 301 ++++++++-----------------------
 drivers/soc/mediatek/mtk-scpsys.h        |  54 ++++++
 include/dt-bindings/power/mt2701-power.h |  27 +++
 7 files changed, 531 insertions(+), 228 deletions(-)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-mt2701.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-mt8173.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
 create mode 100644 include/dt-bindings/power/mt2701-power.h

--
1.9.1
