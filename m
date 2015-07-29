From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Wed, 29 Jul 2015 16:49:35 +0300
Subject: [PATCH net 00/11] net: thunderx: Misc fixes
Message-ID: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miscellaneous fixes for the ThunderX VNIC driver

All the patches can be applied individually.
It's ok to drop some if the maintainer feels uncomfortable
with applying for 4.2.

Sunil Goutham (10):
  net: thunderx: Fix data integrity issues with LDWB
  net: thunderx: Fix memory leak while tearing down interface
  net: thunderx: Fix RQ_DROP miscalculation
  net: thunderx: Fix memory leak when changing queue count
  net: thunderx: Fix TSO packet statistic
  net: thunderx: Suppress alloc_pages() failure warnings
  net: thunderx: Wakeup TXQ only if CQE_TX are processed
  net: thunderx: Set watchdog timeout value
  net: thunderx: Fix crash when changing rss with mutliple traffic flows
  net: thunderx: Add PCI driver shutdown routine

Thanneeru Srinivasulu (1):
  net: thunderx: Fix for crash while BGX teardown

 drivers/net/ethernet/cavium/thunder/nic.h          | 12 ++++-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    | 26 ++++++----
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 55 +++++++++++++++-------
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 17 ++++---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h | 14 ++++--
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |  5 +-
 6 files changed, 92 insertions(+), 37 deletions(-)

-- 
2.4.6
