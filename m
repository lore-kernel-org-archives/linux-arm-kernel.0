From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Thu,  1 Mar 2018 11:47:09 -0600
Subject: [PATCH 0/3] staging: fsl-mc: Move DPBP and DPCON out of staging
Message-ID: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6bd067c48ef ("staging: fsl-mc: Move core bus out of staging")
moves the fsl-mc bus driver infrastructure out of staging to
drivers/bus/fsl-mc. The next step is moving a couple of tightly
connected DPAA2 objects - DPBP (Data Path Buffer Pool) and DPCON
(Data Path Concentrator).

Patch 1 removes dead code from the involved source files.

Patches 2-3 handle moving out the mentioned objects, one at a time.

Bogdan Purcareata (3):
  staging: fsl-mc: Cleanup dpbp and dpcon API
  staging: fsl-mc: Move DPBP out of staging
  staging: fsl-mc: Move DPCON out of staging

 drivers/bus/fsl-mc/Makefile                        |   2 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c  |  71 +-------------
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c |   4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                |  87 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |   3 +-
 drivers/staging/fsl-mc/bus/Makefile                |   2 -
 drivers/staging/fsl-mc/bus/dpbp-cmd.h              |  54 -----------
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             |  53 ----------
 drivers/staging/fsl-mc/include/dpbp.h              |  63 ------------
 drivers/staging/fsl-mc/include/dpcon.h             |  79 ---------------
 include/linux/fsl/mc.h                             | 108 +++++++++++++++++++++
 11 files changed, 202 insertions(+), 324 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (73%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpcon-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpcon.h

-- 
2.7.4
