From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 7 Aug 2017 15:24:33 +0800
Subject: [PATCH v3 0/4] add support of SCPSYS power domain for MediaTek MT7622
Message-ID: <cover.1502090240.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v2:
- reduce code duplication of scpsys_probe across all SoCs

Changes since v1:
- rebase to Linux v4.13-rc1

There are four power domains on MediaTek MT7622 SoC which are respectively
ETHSYS for Ethernet including extra embedded switch, HIF0SYS for PCI-E and
SATA, HIF1SYS for USB and WBSYS for WIFI and Bluetooth.

Those functions could be selectively powered gated when the corresponding
function is no longer to use in order to reach more minimal power
dissipation through the patch series introduced here.

Chen Zhong (1):
  soc: mediatek: add header files required for MT7622 SCPSYS dt-binding

Sean Wang (3):
  dt-bindings: soc: update the binding document for SCPSYS on MediaTek
    MT7622 SoC
  soc: mediatek: reduce code duplication of scpsys_probe across all SoCs
  soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC

 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   3 +
 drivers/soc/mediatek/mtk-scpsys.c                  | 247 ++++++++++++---------
 include/dt-bindings/power/mt7622-power.h           |  22 ++
 include/linux/soc/mediatek/infracfg.h              |   7 +
 4 files changed, 179 insertions(+), 100 deletions(-)
 create mode 100644 include/dt-bindings/power/mt7622-power.h

-- 
2.7.4
