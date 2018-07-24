From: leoyang.li@nxp.com (Li Yang)
Date: Tue, 24 Jul 2018 16:59:55 -0500
Subject: [GIT PULL] updates to soc/fsl drivers for v4.19
Message-ID: <1532469595-12060-1-git-send-email-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

Please merge the following tag to get updates to the soc/fsl drivers:
  Moves DPAA2 DPIO driver from staging to fsl/soc
  Adds multiple-pin support to QE gpio driver

Regards,
Leo


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-for-4.19

for you to fetch changes up to 4625210899095195600062ff8542f37a1c9f5dd4:

  soc: fsl: cleanup Kconfig menu (2018-07-24 16:19:16 -0500)

----------------------------------------------------------------
Various updates to soc/fsl for 4.19

Moves DPAA2 DPIO driver from staging to fsl/soc
Adds multiple-pin support to QE gpio driver

----------------------------------------------------------------
Horia Geant? (1):
      staging: fsl-dpaa2: eth: move generic FD defines to DPIO

Joakim Tjernlund (1):
      soc: fsl: qe: gpio: Add qe_gpio_set_multiple

Li Yang (1):
      soc: fsl: cleanup Kconfig menu

Roy Pledge (3):
      staging: fsl-mc: Move DPIO from staging to drivers/soc/fsl
      staging: fsl-mc: Remove remaining files
      soc: fsl: dpio: Convert DPIO documentation to .rst

 .../networking/dpaa2/dpio-driver.rst               | 29 +++++++++++++++++++---
 Documentation/networking/dpaa2/index.rst           |  1 +
 MAINTAINERS                                        |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                    |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                   |  2 +-
 drivers/soc/fsl/Kconfig                            | 15 ++++++++++-
 drivers/soc/fsl/Makefile                           |  1 +
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile  |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h         |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c      |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-service.c     |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c    |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c     |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h     |  2 +-
 drivers/soc/fsl/qbman/Kconfig                      |  2 +-
 drivers/soc/fsl/qe/Kconfig                         |  2 +-
 drivers/soc/fsl/qe/gpio.c                          | 28 +++++++++++++++++++++
 drivers/staging/Kconfig                            |  2 --
 drivers/staging/Makefile                           |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |  4 +--
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 22 ++++++----------
 drivers/staging/fsl-mc/Kconfig                     |  2 --
 drivers/staging/fsl-mc/Makefile                    |  3 ---
 drivers/staging/fsl-mc/bus/Kconfig                 | 16 ------------
 drivers/staging/fsl-mc/bus/Makefile                |  9 -------
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h  | 12 +++++++++
 .../include => include/soc/fsl}/dpaa2-global.h     |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h  |  0
 29 files changed, 100 insertions(+), 63 deletions(-)
 rename drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (95%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (97%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)
