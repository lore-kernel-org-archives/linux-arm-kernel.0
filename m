From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  2 Feb 2017 16:51:29 +0100
Subject: [PATCHv3 net-next 00/12] net: mvpp2: misc improvements and
 preparation patches
Message-ID: <1486050701-27899-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

This series contains a number of misc improvements and preparation
patches for an upcoming series that adds support for the new PPv2.2
network controller to the mvpp2 driver.

Sorry for the long delay since v2, I was on
vacation/conference/training in January, and therefore wasn't able to
resend a new version earlier. Upcoming versions should arrive much
faster, if there are further comments on this series.

The most significant improvements are:

 - Switching to using build_skb(), which is necessary for the upcoming
   PPv2.2 support, but anyway a good improvement to the current mvpp2
   driver (supporting PPv2.1).

 - Making the driver build on 64-bit platforms.

Changes since v2:

 - Fix remaining 64-bit build warning, reported by David Miller.

 - Adjust how bit mask related definitions are done in "net: mvpp2:
   simplify MVPP2_PRS_RI_* definitions" according to Russell King
   suggestions.

 - Add a patch "net: mvpp2: remove useless arguments in
   mvpp2_rx_{pkts,time}_coal_set", suggested by Russell King.

 - Rework mvpp2_rx_time_coal_set() implementation to avoid overflows
   and rounding errors. I've used the implementation suggested by
   Russell King.

Changes since v1:

 - This series is split as a separate series from the larger patch set
   adding support for PPv2.2 in the mvpp2 driver, as requested by
   David Miller.

 - Rebased on top of v4.10-rc1.

Thanks!

Thomas

Thomas Petazzoni (12):
  net: mvpp2: remove useless arguments in mvpp2_rx_{pkts,time}_coal_set
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
 drivers/net/ethernet/marvell/mvpp2.c | 208 +++++++++++++++++++++--------------
 2 files changed, 125 insertions(+), 86 deletions(-)

-- 
2.7.4
