From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  3 Aug 2017 10:41:54 +0200
Subject: [PATCH net-next v2 0/7] net: mvpp2: add TX interrupts support
Message-ID: <20170803084201.30305-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

So far, the mvpp2 driver was using an hrtimer to handle TX
completion. This patch series adds support for using TX interrupts
(for each CPU) on PPv2.2, the variant of the IP used on Marvell Armada
7K/8K.

Dave: this version can be applied right away, it no longer depends on
Antoine's patch series. Antoine series had some comments, so he will
have to respin later on. Therefore, let's merge this smaller patch
series first.

Changes since v1:

 - Rebased on top of net-next, instead of on top of Antoine's series.

 - Removed the Device Tree patch, as it shouldn't go through the net
   tree.

Thanks!

Thomas

Thomas Petazzoni (7):
  net: mvpp2: fix MVPP21_ISR_RXQ_GROUP_REG definition
  net: mvpp2: remove RX queue group reset code
  net: mvpp2: introduce per-port nrxqs/ntxqs variables
  net: mvpp2: move from cpu-centric naming to "software thread" naming
  net: mvpp2: introduce queue_vector concept
  net: mvpp2: add support for TX interrupts and RX queue distribution
    modes
  dt-bindings: net: marvell-pp2: update interrupt-names with TX
    interrupts

 .../devicetree/bindings/net/marvell-pp2.txt        |  28 +-
 drivers/net/ethernet/marvell/mvpp2.c               | 611 ++++++++++++++++-----
 2 files changed, 488 insertions(+), 151 deletions(-)

-- 
2.9.4
