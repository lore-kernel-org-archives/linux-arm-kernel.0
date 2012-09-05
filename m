From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 5 Sep 2012 10:19:07 +0200
Subject: [PATCH 00/10] net/macb: driver enhancement concerning GEM support,
 ring logic and cleanup
Message-ID: <cover.1346775479.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an enhancement work that began several years ago. I try to catchup with
some performance improvement that has been implemented then by Havard.
The ring index logic and the TX error path modification are the biggest changes
but some cleanup/debugging have been added along the way.
The GEM revision will benefit from the Gigabit support.

The series has been tested on several Atmel AT91 SoC with the two MACB/GEM
flavors.

Havard Skinnemoen (5):
  net/macb: memory barriers cleanup
  net/macb: change debugging messages
  net/macb: Fix a race in macb_start_xmit()
  net/macb: clean up ring buffer logic
  net/macb: Offset first RX buffer by two bytes

Nicolas Ferre (4):
  net/macb: better manage tx errors
  net/macb: tx status is more than 8 bits now
  net/macb: macb_get_drvinfo: add GEM/MACB suffix to differentiate
    revision
  net/macb: ethtool interface: add register dump feature

Patrice Vilchez (1):
  net/macb: Add support for Gigabit Ethernet mode

 drivers/net/ethernet/cadence/macb.c |  408 ++++++++++++++++++++++++-----------
 drivers/net/ethernet/cadence/macb.h |   29 ++-
 2 files changed, 304 insertions(+), 133 deletions(-)

-- 
1.7.10
