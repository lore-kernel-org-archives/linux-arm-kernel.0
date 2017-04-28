From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Fri, 28 Apr 2017 04:50:25 -0500
Subject: [PATCH v3 0/9] staging: Introduce Freescale DPAA2 Ethernet driver
Message-ID: <20170428095034.8842-1-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces the Ethernet driver for Freescale/NXP SoCs
with DPAA2 (DataPath Acceleration Architecture v2). The driver manages
network objects discovered on the fsl-mc bus. A description of the
driver can be found in the associated README file.

The patchset consists of:
* A set of libraries containing APIs for configuring and controlling
Management Complex (MC) networking objects
* The DPAA2 Ethernet basic driver
* A couple of patches adding ethtool and debug support

v3 changes:
 - add contact info in TODO file
v2 changes:
 - update path of include header files since fsl-mc bus driver
   is still in staging
 - minor updates in patch #4 due to networking API changes

Ioana Radulescu (9):
  bus: fsl-mc: add DPCON object APIs
  staging: fsl-dpaa2/eth: Add Ethernet driver overview document
  staging: fsl-dpaa2/eth: Add APIs for DPNI objects
  staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driver
  staging: fsl-dpaa2/eth: Add ethtool support
  staging: fsl-dpaa2/eth: Add driver specific stats
  staging: fsl-dpaa2/eth: Add trace points
  staging: fsl-dpaa2/eth: Add TODO file
  staging: fsl-dpaa2/eth: Add maintainer for Ethernet driver

 MAINTAINERS                                        |    6 +
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/fsl-dpaa2/Kconfig                  |   17 +
 drivers/staging/fsl-dpaa2/Makefile                 |    5 +
 drivers/staging/fsl-dpaa2/ethernet/Makefile        |   10 +
 drivers/staging/fsl-dpaa2/ethernet/README          |  186 ++
 drivers/staging/fsl-dpaa2/ethernet/TODO            |   14 +
 .../staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h   |  185 ++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     | 2520 ++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  348 +++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c |  279 +++
 drivers/staging/fsl-dpaa2/ethernet/dpkg.h          |  176 ++
 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h      |  541 +++++
 drivers/staging/fsl-dpaa2/ethernet/dpni.c          | 1595 +++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpni.h          |  832 +++++++
 drivers/staging/fsl-dpaa2/ethernet/net.h           |  480 ++++
 drivers/staging/fsl-mc/bus/Makefile                |    3 +-
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             |   69 +-
 drivers/staging/fsl-mc/bus/dpcon.c                 |  317 +++
 drivers/staging/fsl-mc/include/dpcon.h             |  115 +
 21 files changed, 7677 insertions(+), 24 deletions(-)
 create mode 100644 drivers/staging/fsl-dpaa2/Kconfig
 create mode 100644 drivers/staging/fsl-dpaa2/Makefile
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/Makefile
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/README
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/TODO
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpkg.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpni.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/dpni.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethernet/net.h
 create mode 100644 drivers/staging/fsl-mc/bus/dpcon.c
 create mode 100644 drivers/staging/fsl-mc/include/dpcon.h

-- 
2.11.0
