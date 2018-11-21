From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 21 Nov 2018 13:41:06 +0200
Subject: [PATCH v3 0/3] dpaa_eth: add ethtool coalesce control
Message-ID: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add control of the DPAA portal interrupt coalescing settings from
ethtool.

changes from v2: read ithresh from HW, set previous values on failure
changes from v1: added range checking for the QMan APIs

Madalin Bucur (3):
  soc: fsl: qbman: read ithresh from HW
  soc/qman: add return value to interrupt coalesce changing APIs
  dpaa_eth: add ethtool coalesce control

 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 71 ++++++++++++++++++++++
 drivers/soc/fsl/qbman/qman.c                       | 35 ++++++++---
 include/soc/fsl/qman.h                             |  8 ++-
 3 files changed, 104 insertions(+), 10 deletions(-)

-- 
2.1.0
