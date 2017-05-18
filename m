From: isubramanian@apm.com (Iyappan Subramanian)
Date: Thu, 18 May 2017 15:13:42 -0700
Subject: [PATCH v2 net-next 0/2] Check all RGMII phy mode variants
Message-ID: <1495145624-29463-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set,
     - adds phy_interface_mode_is_rgmii() helper function
     - addresses review comment from previous patch set, by calling
       phy_interface_mode_is_rgmii() to address all RGMII variants

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
v2: Address review comments from v1
     - adds phy_interface_mode_is_rgmii() helper function
     - addresses review comment from previous patch set, by calling
       phy_interface_mode_is_rgmii() to address all RGMII variants
v1:
     - Initial version
---

Iyappan Subramanian (2):
  include: linux: Add helper function to check phy interface mode
  drivers: net: xgene: Check all RGMII phy mode variants

 drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c |  6 +++---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c      | 12 ++++++------
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c    | 15 +++++++++------
 include/linux/phy.h                                 | 14 ++++++++++++--
 4 files changed, 30 insertions(+), 17 deletions(-)

-- 
1.9.1
