From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Fri,  3 Mar 2017 16:17:46 +0530
Subject: [PATCH 0/4] net: thunderx: Miscellaneous fixes
Message-ID: <1488538070-12549-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This patch set fixes multiples issues such as IOMMU
translation faults when kernel is booted with IOMMU enabled
on host, incorrect MAC ID reading from ACPI tables and IPv6
UDP packet drop due to failure of checksum validation.

Sunil Goutham (3):
  net: thunderx: Fix IOMMU translation faults
  net: thunderx: Fix LMAC mode debug prints for QSGMII mode
  net: thunderx: Fix invalid mac addresses for node1 interfaces

Thanneeru Srinivasulu (1):
  net: thunderx: Allow IPv6 frames with zero UDP checksum

 drivers/net/ethernet/cavium/thunder/nic.h          |   1 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  12 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 193 +++++++++++++++++----
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |   2 +
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |  64 +++++--
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |   1 -
 6 files changed, 223 insertions(+), 50 deletions(-)

-- 
2.7.4
