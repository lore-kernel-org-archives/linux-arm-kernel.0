From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 28 Dec 2016 17:45:56 +0100
Subject: [PATCHv2 net-next 00/11] net: mvpp2: misc improvements and
 preparation patches
Message-ID: <1482943567-12483-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series contains a number of misc improvements and preparation
patches for an upcoming series that adds support for the new PPv2.2
network controller to the mvpp2 driver.

The most significant improvements are:

 - Switching to using build_skb(), which is necessary for the upcoming
   PPv2.2 support, but anyway a good improvement to the current mvpp2
   driver (supporting PPv2.1).

 - Making the driver build on 64-bit platforms.

Changes since v1:

 - This series is split as a separate series from the larger patch set
   adding support for PPv2.2 in the mvpp2 driver, as requested by
   David Miller.

 - Rebased on top of v4.10-rc1.

Thanks!

Thomas

Thomas Petazzoni (11):
  net: mvpp2: handle too large value handling in
    mvpp2_rx_pkts_coal_set()
  net: mvpp2: handle too large value in mvpp2_rx_time_coal_set()
  net: mvpp2: release reference to txq_cpu[] entry after unmapping
  net: mvpp2: remove unused 'tx_skb' field of 'struct mvpp2_tx_queue'
  net: mvpp2: drop useless fields in mvpp2_bm_pool and related code
  net: mvpp2: simplify mvpp2_bm_bufs_add()
  net: mvpp2: remove unused register definitions
  net: mvpp2: fix indentation of MVPP2_EXT_GLOBAL_CTRL_DEFAULT
  net: mvpp2: simplify MVPP2_PRS_RI_* definitions
  net: mvpp2: switch to build_skb() in the RX path
  net: mvpp2: enable building on 64-bit platforms

 drivers/net/ethernet/marvell/Kconfig |   3 +-
 drivers/net/ethernet/marvell/mvpp2.c | 161 ++++++++++++++++++++---------------
 2 files changed, 93 insertions(+), 71 deletions(-)

-- 
2.7.4
