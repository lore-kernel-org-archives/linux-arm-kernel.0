From: roy.pledge@nxp.com (Roy Pledge)
Date: Thu,  5 Jul 2018 14:41:11 -0500
Subject: [PATCH 0/2] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Message-ID: <20180705194113.16256-1-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-mc/bus/dpio
directory to the drivers/soc/fsl directory.

The DPIO driver enables access to the Queue and Buffer Managemer (QBMAN)
hardware of NXP DPAA2 devices. This is a prerequiste for moving the DPAA2
Ethernet device driver from the staging directory.

Roy Pledge (2):
  staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
  drivers/staging: Remove fsl-mc driver from staging

 MAINTAINERS                                              |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                          |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                         |  2 +-
 drivers/soc/fsl/Kconfig                                  | 10 ++++++++++
 drivers/soc/fsl/Makefile                                 |  1 +
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile    |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h  |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c   |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c  |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c      |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h      |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c  |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h  |  2 +-
 drivers/staging/Kconfig                                  |  2 --
 drivers/staging/Makefile                                 |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h           |  4 ++--
 drivers/staging/fsl-mc/Kconfig                           |  2 --
 drivers/staging/fsl-mc/Makefile                          |  3 ---
 drivers/staging/fsl-mc/bus/Kconfig                       | 16 ----------------
 drivers/staging/fsl-mc/bus/Makefile                      |  9 ---------
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h        |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-global.h    |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h        |  0
 24 files changed, 20 insertions(+), 42 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

--
2.7.4
