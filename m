From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Fri,  2 Mar 2018 04:23:57 -0600
Subject: [PATCH v2 0/2] staging: fsl-mc: Move DPBP and DPCON out of staging
Message-ID: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous submission: https://lkml.org/lkml/2018/3/1/733

Commit 6bd067c48ef ("staging: fsl-mc: Move core bus out of staging")
moves the fsl-mc bus driver infrastructure out of staging to
drivers/bus/fsl-mc. The next step is moving a couple of tightly
connected DPAA2 objects - DPBP (Data Path Buffer Pool) and DPCON
(Data Path Concentrator).

The patches handle moving out the mentioned objects, one at a time.

v1 -> v2:
- previous cleanup patch already applied, so removed from patchset
- properly refactor #include line (Laurentiu)

Bogdan Purcareata (2):
  staging: fsl-mc: Move DPBP out of staging
  staging: fsl-mc: Move DPCON out of staging

 drivers/bus/fsl-mc/Makefile                        |   2 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c  |   4 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c |   4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                |  87 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |   3 +-
 drivers/staging/fsl-mc/bus/Makefile                |   2 -
 drivers/staging/fsl-mc/bus/dpbp-cmd.h              |  44 ---------
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             |  53 ----------
 drivers/staging/fsl-mc/include/dpbp.h              |  53 ----------
 drivers/staging/fsl-mc/include/dpcon.h             |  79 ---------------
 include/linux/fsl/mc.h                             | 108 +++++++++++++++++++++
 11 files changed, 202 insertions(+), 237 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpcon-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpcon.h

-- 
2.7.4
