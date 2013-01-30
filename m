From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 31 Jan 2013 00:37:33 +0530
Subject: [PATCH v2 0/2] Add CPSW VLAN Support
Message-ID: <1359572855-12344-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPSW is capable of filtering VLAN packets in hardware. This patch series
implements VLAN support to CPSW driver.
This patch series is tested on net-next with AM335x EVM with ping test.

Changes from initial version
* added vlan support to existing add/delete unicast/multicast apis
* Made driver as default VLAN enabled so that drivers need to be recompiled
  when stack is compiled with VLAN

Mugunthan V N (2):
  drivers: net: cpsw: Add helper functions for VLAN ALE implementation
  drivers: net:ethernet: cpsw: add support for VLAN

 Documentation/devicetree/bindings/net/cpsw.txt |    2 +
 drivers/net/ethernet/ti/cpsw.c                 |  100 ++++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_ale.c             |  106 +++++++++++++++++++++---
 drivers/net/ethernet/ti/cpsw_ale.h             |   20 +++--
 include/linux/platform_data/cpsw.h             |    1 +
 5 files changed, 205 insertions(+), 24 deletions(-)

-- 
1.7.9.5
