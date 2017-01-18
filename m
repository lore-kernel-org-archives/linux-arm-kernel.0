From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 18 Jan 2017 17:39:30 -0500
Subject: [PATCH 00/10] fsl/qbman: ARM Enablement
Message-ID: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables DPAA1 QBMan devices for ARM and
ARM64 architectures. This allows the LS1043A and LS1046A to use
QBMan functionality.


Claudiu Manoil (4):
  soc/qbman: Use portable mapping for the FQD reserved memory
  soc/qbman: Drop L1_CACHE_BYTES compile time check
  soc/qbman: Add ARM equivalent for flush_dcache_range()
  soc/qbman: Add missing headers on ARM

Madalin Bucur (4):
  soc/qbman: Drop set/clear_bits usage
  soc/qbman: add QMAN_REV32
  soc/qbman: different register offsets on ARM
  fsl/qbman: Enable FSL_LAYERSCAPE config on ARM

Roy Pledge (1):
  soc/qbman: Rework ioremap() calls for ARM/PPC

Valentin Rothberg (1):
  soc/qbman: Fix ARM32 typo

 drivers/soc/fsl/qbman/Kconfig       |    2 +-
 drivers/soc/fsl/qbman/bman.c        |   24 +++++++++++++++++-
 drivers/soc/fsl/qbman/bman_portal.c |   16 +++++++++---
 drivers/soc/fsl/qbman/dpaa_sys.h    |    8 +++---
 drivers/soc/fsl/qbman/qman.c        |   46 ++++++++++++++++++++++++++++++++---
 drivers/soc/fsl/qbman/qman_ccsr.c   |   16 ++++++++----
 drivers/soc/fsl/qbman/qman_portal.c |   16 +++++++++---
 drivers/soc/fsl/qbman/qman_priv.h   |    1 +
 8 files changed, 107 insertions(+), 22 deletions(-)

--
1.7.9.5
