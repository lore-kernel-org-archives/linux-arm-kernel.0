From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 8 Jan 2016 11:32:44 +0800
Subject: [PATCH v2 0/4] Mediatek MT2701 SCPSYS power domain support
Message-ID: <1452223968-6566-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based on 4.4-rc7, add scpsys power domain support for
Mediatek MT2701.

This patchset also separate MT8173 scpsys driver into common part
(mtk-scpsys.c) and platform part (mtk-scpsys-mt8173.c), so that MT2701
scpsys driver can share most implementation with MT8173.

MT8173 and MT2701 scpsys init level are now subsys_init. Please refer to [1]
to see discussion details.

changes since v1:
- Make MTK_SCPSYS in Kconfig invisible from users.
- Add comments for changing scpsys init level to subsys_init.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2015-December/003416.html

James Liao (2):
  soc: mediatek: Separate scpsys driver common code
  soc: mediatek: Init MT8173 scpsys driver earlier

Shunli Wang (2):
  soc: mediatek: Add MT2701 power dt-bindings
  soc: mediatek: Add MT2701 scpsys driver

 drivers/soc/mediatek/Kconfig             |  27 ++-
 drivers/soc/mediatek/Makefile            |   2 +
 drivers/soc/mediatek/mtk-scpsys-mt2701.c | 172 ++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys-mt8173.c | 201 +++++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c        | 301 ++++++++-----------------------
 drivers/soc/mediatek/mtk-scpsys.h        |  54 ++++++
 include/dt-bindings/power/mt2701-power.h |  27 +++
 7 files changed, 554 insertions(+), 230 deletions(-)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-mt2701.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-mt8173.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
 create mode 100644 include/dt-bindings/power/mt2701-power.h

--
1.9.1
