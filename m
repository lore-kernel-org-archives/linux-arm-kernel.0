From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 7 Feb 2017 08:15:20 -0600
Subject: [PATCH 00/10][v2] staging: fsl-mc: fixes and cleanups
Message-ID: <20170207141530.12979-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

First 4 patches fix several driver model related
issues and drop an useless atomic global.
The rest of the patches are cleanups mostly
consisting in removing dead code.

v2:
 - split slab cache removal in distinct patch
 - redundant deallocation dropped in patch that adds release callback

Laurentiu Tudor (10):
  staging: fsl-mc: drop root dprc counting
  staging: fsl-mc: fix device ref counting
  staging: fsl-mc: add device release callback
  staging: fsl-mc: don't use devres api for refcounted objects
  staging: fsl-mc: remove slab cache for mc devices
  staging: fsl-mc: dpmcp: drop unused APIs
  staging: fsl-mc: dpmng: drop unused prototype
  staging: fsl-mc: dpbp: drop unused APIs
  staging: fsl-mc: dpbp: add a few missing EXPORT_SYMBOL()s
  staging: fsl-mc: dprc: drop unused APIs

 drivers/staging/fsl-mc/bus/dpbp-cmd.h    | 116 ------
 drivers/staging/fsl-mc/bus/dpbp.c        | 452 +--------------------
 drivers/staging/fsl-mc/bus/dpmcp-cmd.h   |  95 -----
 drivers/staging/fsl-mc/bus/dpmcp.c       | 382 ------------------
 drivers/staging/fsl-mc/bus/dpmcp.h       | 100 +----
 drivers/staging/fsl-mc/bus/dprc-cmd.h    |  18 -
 drivers/staging/fsl-mc/bus/dprc-driver.c |   1 +
 drivers/staging/fsl-mc/bus/dprc.c        | 666 -------------------------------
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c  |  75 +---
 drivers/staging/fsl-mc/include/dpbp.h    | 129 ------
 drivers/staging/fsl-mc/include/dpmng.h   |   4 -
 drivers/staging/fsl-mc/include/dprc.h    | 243 -----------
 12 files changed, 30 insertions(+), 2251 deletions(-)

-- 
1.8.3.1
