From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Mon,  5 Feb 2018 08:07:41 -0600
Subject: [PATCH v6 0/2] staging: fsl-mc: Move bus driver out of staging
Message-ID: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous submission: https://lkml.org/lkml/2018/1/26/215

Split the code into moving out the core bus infrastructure separate from
the irqchip glue code. Add a Kconfig dependency on ARM_GIC_V3_ITS.
Integrate the documentation with the kernel build system.

This patchset only handles moving the fsl-mc bus core out of staging.
The remaining objects (DPBP, DPCON) and drivers (dpio, dpaa2-eth) will
be moved out in subsequent patches.

Notes:
    -v6:
      - generate patchset with rename detection enabled (GregKH)
      - add Kconfig dependecy on ARM_GIC_V3_ITS (Mark Zyngier)
    -v5:
      - split irqchip glue code to separate patch (GregKH)
      - integrate doc with the kernel build system
    -v4:
      - regenerated patch with renames detection disabled (Andrew Lunn)
    -v3:
      - rebased
    -v2:
      - group irqchip gic its glue code together with the rest (Marc Zyngier)

Bogdan Purcareata (2):
  staging: fsl-mc: Move core bus out of staging
  staging: fsl-mc: Move irqchip code out of staging

 Documentation/networking/dpaa2/index.rst               |  8 ++++++++
 .../networking/dpaa2}/overview.rst                     |  0
 Documentation/networking/index.rst                     |  1 +
 MAINTAINERS                                            |  3 ++-
 drivers/bus/Kconfig                                    |  2 ++
 drivers/bus/Makefile                                   |  4 ++++
 drivers/bus/fsl-mc/Kconfig                             | 16 ++++++++++++++++
 drivers/bus/fsl-mc/Makefile                            | 16 ++++++++++++++++
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c     |  2 +-
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c   |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c      |  3 ++-
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c       |  2 +-
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c    |  0
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c    |  1 +
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h         |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c     |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c    |  2 +-
 drivers/irqchip/Kconfig                                |  6 ++++++
 drivers/irqchip/Makefile                               |  1 +
 .../fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c |  4 +---
 drivers/staging/fsl-dpaa2/ethernet/README              |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c         |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c              |  2 +-
 drivers/staging/fsl-mc/TODO                            | 18 ------------------
 drivers/staging/fsl-mc/bus/Kconfig                     | 10 ----------
 drivers/staging/fsl-mc/bus/Makefile                    | 15 ++-------------
 drivers/staging/fsl-mc/bus/dpbp.c                      |  2 +-
 drivers/staging/fsl-mc/bus/dpcon.c                     |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c          |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c         |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c                 |  2 +-
 .../staging/fsl-mc/include => include/linux/fsl}/mc.h  |  0
 32 files changed, 76 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/networking/dpaa2/index.rst
 rename {drivers/staging/fsl-mc => Documentation/networking/dpaa2}/overview.rst (100%)
 create mode 100644 drivers/bus/fsl-mc/Kconfig
 create mode 100644 drivers/bus/fsl-mc/Makefile
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c (99%)
 rename drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c (97%)
 delete mode 100644 drivers/staging/fsl-mc/TODO
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc.h (100%)

-- 
2.7.4
