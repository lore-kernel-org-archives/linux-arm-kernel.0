From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 26 Apr 2017 16:38:46 -0700
Subject: [PATCH net-next 0/9] drivers: net: xgene: Add ethtool stats and bug
 fixes
Message-ID: <1493249935-30759-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set,

- adds ethtool extended statistics support
- addresses errata workarounds
- fixes bugs related to statistics

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
---

Quan Nguyen (9):
  drivers: net: xgene: Protect indirect MAC access
  drivers: net: xgene: Remove redundant local stats
  drivers: net: xgene: Refactor statistics error parsing code
  drivers: net: xgene: Remove unused macros
  drivers: net: xgene: Extend ethtool statistics
  drivers: net: xgene: Add rx_overrun/tx_underrun statistic
  drivers: net: xgene: Workaround for HW errata 10GE_4
  drivers: net: xgene: Add frame recovered statistics counter for errata
    10GE_8/ENET_11
  drivers: net: xgene: Workaround for HW errata 10GE_10/ENET_15

 .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    | 132 ++++++++++++++++++++-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |  41 ++++++-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |  66 +++++++++--
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |  57 ++++++---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |  13 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c  |  42 ++++++-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c  |  35 ++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.h  |   5 +
 8 files changed, 357 insertions(+), 34 deletions(-)

-- 
1.9.1
