From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 21 Jul 2017 11:57:11 +0800
Subject: [PATCH 0/3] add support of SCPSYS power domain for MediaTek MT7622
Message-ID: <cover.1500608650.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

There are four power domains on MediaTek MT7622 SoC which are respectively
ETHSYS for Ethernet including extra embedded switch, HIF0SYS for PCI-E and
SATA, HIF1SYS for USB and WBSYS for WIFI and Bluetooth.

Those functions could be selectively powered gated when the corresponding
function is no longer to use in order to reach more minimal power
dissipation through the patch series introduced here.

Chen Zhong (2):
  soc: mediatek: add header files required for MT7622 SCPSYS dt-binding
  soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC

Sean Wang (1):
  dt-bindings: soc: update the binding document for SCPSYS on MediaTek
    MT7622 SoC

 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  3 +
 drivers/soc/mediatek/mtk-scpsys.c                  | 76 ++++++++++++++++++++++
 include/dt-bindings/power/mt7622-power.h           | 22 +++++++
 include/linux/soc/mediatek/infracfg.h              |  8 ++-
 4 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/mt7622-power.h

-- 
2.7.4
