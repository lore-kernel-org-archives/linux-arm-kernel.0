From: isubramanian@apm.com (Iyappan Subramanian)
Date: Thu,  1 Dec 2016 16:41:36 -0800
Subject: [PATCH net-next 0/8] drivers: net: xgene: Add Jumbo and Pause frame
 support
Message-ID: <1480639304-18757-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds,

1. Jumbo frame support
2. Pause frame based flow control

and fixes RSS for non-TCP/UDP packets.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
Iyappan Subramanian (8):
  drivers: net: xgene: Add helper function
  drivers: net: xgene: Configure classifier with pagepool
  drivers: net: xgene: Add support for Jumbo frame
  drivers: net: xgene: Add change_mtu function
  drivers: net: xgene: fix: RSS for non-TCP/UDP
  drivers: net: xgene: Add flow control configuration
  drivers: net: xgene: Add flow control initialization
  drivers: net: xgene: ethtool: Add get/set_pauseparam

 drivers/net/ethernet/apm/xgene/xgene_enet_cle.c    | 110 ++++++-
 drivers/net/ethernet/apm/xgene/xgene_enet_cle.h    |   3 +
 .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    |  70 +++++
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     | 140 ++++++++-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |  27 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   | 336 +++++++++++++++++++--
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |  30 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_ring2.c  |   1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c  | 146 +++++++--
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c  | 121 +++++++-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.h  |   9 +
 11 files changed, 895 insertions(+), 98 deletions(-)

-- 
1.9.1
