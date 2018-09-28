From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Fri, 28 Sep 2018 11:43:19 +0300
Subject: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions 
Message-ID: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set brings a number of fixes and the option to control
the QMan portal interrupt coalescing.

Changes from v1:
 - change CPU 0 with any online CPU to allow CPU 0 to be taken offline
 - move common code in a function
 - address all places in the code where the portal interrupt was affined
   to CPU 0
 - remove unrelated change from patch adding 64 bit DMA addressing
   requirement

Madalin Bucur (2):
  soc/fsl/qbman: replace CPU 0 with any online CPU in hotplug handlers
  soc/fsl_qbman: export coalesce change API

Roy Pledge (3):
  soc/fsl/qbman: Check if CPU is offline when initializing portals
  soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
  soc/fsl/qbman: Use last response to determine valid bit

 drivers/soc/fsl/qbman/Kconfig       |  2 +-
 drivers/soc/fsl/qbman/bman.c        |  6 ++---
 drivers/soc/fsl/qbman/bman_portal.c |  4 ++-
 drivers/soc/fsl/qbman/dpaa_sys.h    | 20 ++++++++++++++
 drivers/soc/fsl/qbman/qman.c        | 53 ++++++++++++++++++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c |  6 +++--
 include/soc/fsl/qman.h              | 27 +++++++++++++++++++
 7 files changed, 104 insertions(+), 14 deletions(-)

-- 
2.1.0
