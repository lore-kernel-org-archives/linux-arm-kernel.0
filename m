From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Fri, 22 May 2015 18:28:14 -0700
Subject: [PATCH net-next v5 0/2] Adding support for Cavium ThunderX network
 controller
Message-ID: <1432344498-17131-1-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Cavium ThunderX network controller.

changes in v5:
 * __packed were removed.  now we rely on C language ABI
 * nic_dbg() -> netdev_dbg()
 * fixes for a typo, constant spelling and using BIT_ULL
 * use print_hex_dump()
 * unnecessary conditions in a long if() chain were removed

changes in v4:
 * the patch "pci: Add Cavium PCI vendor id" was attributed correctly
 * a note that Cavium id is used in many drivers was added
 * the license comments now match MODULE_LICENSE
 * a comment explaining usage of writeq_relaxed()/readq_relaxed() was added

changes in v3:
 * code cleanup
 * issues discovered by reviewers were addressed

changes in v2:
 * non-generic module parameters removed
 * ethtool support added (nicvf_set_rxnfc())

Sunil Goutham (2):
  pci: Add Cavium PCI vendor id
  net: Adding support for Cavium ThunderX network controller

 MAINTAINERS                                        |    7 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/cavium/Kconfig                |   40 +
 drivers/net/ethernet/cavium/Makefile               |    5 +
 drivers/net/ethernet/cavium/thunder/Makefile       |   11 +
 drivers/net/ethernet/cavium/thunder/nic.h          |  419 ++++++
 drivers/net/ethernet/cavium/thunder/nic_main.c     |  940 +++++++++++++
 drivers/net/ethernet/cavium/thunder/nic_reg.h      |  213 +++
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |  624 +++++++++
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 1324 ++++++++++++++++++
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 1413 ++++++++++++++++++++
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |  375 ++++++
 drivers/net/ethernet/cavium/thunder/q_struct.h     |  701 ++++++++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |  966 +++++++++++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |  223 +++
 include/linux/pci_ids.h                            |    2 +
 17 files changed, 7265 insertions(+)
 create mode 100644 drivers/net/ethernet/cavium/Kconfig
 create mode 100644 drivers/net/ethernet/cavium/Makefile
 create mode 100644 drivers/net/ethernet/cavium/thunder/Makefile
 create mode 100644 drivers/net/ethernet/cavium/thunder/nic.h
 create mode 100644 drivers/net/ethernet/cavium/thunder/nic_main.c
 create mode 100644 drivers/net/ethernet/cavium/thunder/nic_reg.h
 create mode 100644 drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
 create mode 100644 drivers/net/ethernet/cavium/thunder/nicvf_main.c
 create mode 100644 drivers/net/ethernet/cavium/thunder/nicvf_queues.c
 create mode 100644 drivers/net/ethernet/cavium/thunder/nicvf_queues.h
 create mode 100644 drivers/net/ethernet/cavium/thunder/q_struct.h
 create mode 100644 drivers/net/ethernet/cavium/thunder/thunder_bgx.c
 create mode 100644 drivers/net/ethernet/cavium/thunder/thunder_bgx.h

-- 
2.4.1
