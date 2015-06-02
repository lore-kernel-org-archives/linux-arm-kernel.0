From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Tue, 2 Jun 2015 11:00:17 -0700
Subject: [PATCH 00/10] net: thunderx: fix problems reported by static check
 tools
Message-ID: <1433268028-23992-1-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are fixes for the problems that were reported by static check tools.

Aleksey Makarov (9):
  net: thunderx: fix constants
  net: thunderx: introduce a function for mailbox access
  net: thunderx: rework mac address handling
  net: thunderx: delete unused variables
  net: thunderx: add static
  net: thunderx: fix nicvf_set_rxfh()
  net: thunderx: remove unneeded type conversions
  net: thunderx: check if memory allocation was successful
  net: thunderx: use GFP_KERNEL in thread context

Robert Richter (1):
  net: thunderx: Cleanup duplicate NODE_ID macros, add nic_get_node_id()

 drivers/net/ethernet/cavium/thunder/nic.h          | 16 +++--
 drivers/net/ethernet/cavium/thunder/nic_main.c     | 12 +---
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |  3 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 73 +++++++++++-----------
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  9 +--
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  | 18 +++---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |  7 +--
 7 files changed, 67 insertions(+), 71 deletions(-)

-- 
2.4.1
