From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Oct 2012 11:17:52 +0100
Subject: [PATCH v3 00/10] net/macb: driver enhancement concerning GEM support,
 ring logic and cleanup
Message-ID: <cover.1351591858.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an enhancement work that began several years ago. I try to catchup with
some performance improvement that has been implemented then by Havard.
The ring index logic and the TX error path modification are the biggest changes
but some cleanup/debugging have been added along the way.
The GEM revision will benefit from the Gigabit support.
Newer pinctrl infrastructure support is added but it is optional.

The series has been tested on several Atmel AT91 SoC with the two MACB/GEM
flavors.

v3: - rebased on net-next to take into account current effor to merge
      at91_ether with macb drivers
    - add additional patch to use the new pinctrl infrastructure
v2: - modify the tx error handling: now uses a workqueue
    - information provided by ethtool -i were not accurate: removed

Havard Skinnemoen (4):
  net/macb: memory barriers cleanup
  net/macb: change debugging messages
  net/macb: clean up ring buffer logic
  net/macb: Offset first RX buffer by two bytes

Jean-Christophe PLAGNIOL-VILLARD (1):
  net/macb: add pinctrl consumer support

Nicolas Ferre (4):
  net/macb: remove macb_get_drvinfo()
  net/macb: tx status is more than 8 bits now
  net/macb: ethtool interface: add register dump feature
  net/macb: better manage tx errors

Patrice Vilchez (1):
  net/macb: Add support for Gigabit Ethernet mode

 drivers/net/ethernet/cadence/macb.c | 446 +++++++++++++++++++++++++-----------
 drivers/net/ethernet/cadence/macb.h |  30 ++-
 2 files changed, 334 insertions(+), 142 deletions(-)

-- 
1.8.0
