From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 26 Mar 2018 15:05:30 -0400
Subject: [PATCH v3 0/4] drives/soc/fsl: Move DPIO driver out of staging
Message-ID: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset moves the NXP DPIO (Datapath I/O Driver) out of the
drivers/staging directory and into the drivers/soc/fsl directory.

The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
hardware on NXP DPAA2 devices. This is a prerequiset to moving the
DPAA2 Etherney driver out of staging.

Changes in v3:
	- Update caam files that use dpaa2 frame header files
	- Fix spare errors and memory leak
	- Remove empty staging/drivers/fsl-mc directory

Changes in v2:
	- Fix minor conflict in latest linux-next branch
	- Generate patch using -M


Roy Pledge (4):
  drivers/staging/fsl-mc: Use memremap for DPIO cache enabled area
  drivers/staging/fsl-mc: Fix DPIO error path issues
  staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
  drivers/staging: Remove fsl-mc driver from staging

 MAINTAINERS                                        |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                    |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                   |  2 +-
 drivers/soc/fsl/Kconfig                            | 10 +++++
 drivers/soc/fsl/Makefile                           |  1 +
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile  |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h         |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c      | 51 +++++++++++++++-------
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-service.c     |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c    |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c     |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h     |  6 +--
 drivers/staging/Kconfig                            |  2 -
 drivers/staging/Makefile                           |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  4 +-
 drivers/staging/fsl-mc/Kconfig                     |  2 -
 drivers/staging/fsl-mc/Makefile                    |  3 --
 drivers/staging/fsl-mc/bus/Kconfig                 | 16 -------
 drivers/staging/fsl-mc/bus/Makefile                |  9 ----
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h  |  0
 .../include => include/soc/fsl}/dpaa2-global.h     |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h  |  2 +-
 24 files changed, 58 insertions(+), 59 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (83%)
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
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (99%)

--
2.7.4
