From: aleksey.makarov@cavium.com (Aleksey Makarov)
Date: Tue,  7 Nov 2017 22:07:00 +0300
Subject: [PATCH net-next 0/2] net: thunderx: add support for PTP clock
Message-ID: <20171107190704.15458-1-aleksey.makarov@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for IEEE 1588 Precision Time Protocol
to Cavium ethernet driver.

The first patch adds support for the Precision Time Protocol Clocks and
Timestamping coprocessor (PTP) found on Cavium processors.
It registers a new PTP clock in the PTP core and provides functions
to use the counter in BGX, TNS, GTI, and NIC blocks.

The second patch introduces support for the PTP protocol to the
Cavium ThunderX ethernet driver.

Radoslaw Biernacki (1):
  net: add support for Cavium PTP coprocessor

Sunil Goutham (1):
  net: thunderx: add timestamping support

 drivers/net/ethernet/cavium/Kconfig                |  14 +
 drivers/net/ethernet/cavium/Makefile               |   1 +
 drivers/net/ethernet/cavium/common/Makefile        |   1 +
 drivers/net/ethernet/cavium/common/cavium_ptp.c    | 353 +++++++++++++++++++++
 drivers/net/ethernet/cavium/common/cavium_ptp.h    |  78 +++++
 drivers/net/ethernet/cavium/thunder/nic.h          |  15 +
 drivers/net/ethernet/cavium/thunder/nic_main.c     |  58 +++-
 drivers/net/ethernet/cavium/thunder/nic_reg.h      |   1 +
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |  29 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 173 +++++++++-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  26 ++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |  29 ++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |   4 +
 13 files changed, 776 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/cavium/common/Makefile
 create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.c
 create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.h

-- 
2.15.0
