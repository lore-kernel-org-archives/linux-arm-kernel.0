From: jlu@pengutronix.de (Jan Luebbe)
Date: Mon, 28 Aug 2017 17:25:15 +0200
Subject: [PATCH 0/2] fix 4GB DRAM window support on mvebu
Message-ID: <20170828152517.24506-1-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current MBUS DRAM window calculation fails for 4GB windows because it
overflows. This is fixed in the first patch by using u64 instead of u32 to
store the size. The second excplicitly checks that we don't try to configure a
too large memory window in the pci driver.

As they don't depend on each other, they could also go in separatly.

Jan Luebbe (2):
  bus: mbus: fix window size calculation for 4GB windows
  PCI: mvebu: Check DRAM window size

 drivers/bus/mvebu-mbus.c     |  2 +-
 drivers/pci/host/pci-mvebu.c | 27 ++++++++++++++++++++++-----
 include/linux/mbus.h         |  4 ++--
 3 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.11.0
