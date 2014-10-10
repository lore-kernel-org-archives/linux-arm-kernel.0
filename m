From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 10 Oct 2014 13:18:33 -0700
Subject: [PATCH v1 0/3] Add SGMII based 1GbE support to APM X-Gene SoC
 ethernet driver
Message-ID: <1412972316-16344-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding SGMII based 1GbE basic support to APM X-Gene SoC ethernet driver.

v1:
* Initial version
---

Iyappan Subramanian (3):
  dtb: Add SGMII based 1GbE node to APM X-Gene SoC device tree
  drivers: net: xgene: Add SGMII based 1GbE support
  drivers: net: xgene: Add SGMII based 1GbE ethtool support

 arch/arm64/boot/dts/apm-mustang.dts                |   4 +
 arch/arm64/boot/dts/apm-storm.dtsi                 |  24 ++
 drivers/net/ethernet/apm/xgene/Makefile            |   2 +-
 .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    |  25 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |   1 -
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |  24 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |   5 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c  | 407 +++++++++++++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.h  |  41 +++
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c  |   3 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.h  |   4 -
 12 files changed, 518 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c
 create mode 100644 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.h

-- 
1.9.1
