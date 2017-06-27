From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 27 Jun 2017 17:41:20 +0300
Subject: [PATCH v2 00/15] staging: fsl-mc: clean up header files
Message-ID: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This patch series contain mainly clean-ups of the mc-bus header files
with the final goal of reorganizing them in just 2 files: a public
and a private one, as per GregKH suggestion [1].
Here's a summary of the header reorganizing:
 - existing mc.h used as public header (contained most of the public API)
 - existing fsl-mc-private.h used for private header
 - mc-bus.h merged both in public and private header
 - mc-sys.h and mc-cmd.h merged in public header
 - dprc.h made private
 - dpmng.h deleted

[1] https://patchwork.kernel.org/patch/9775683/

version 2 changes
 - fix compilation issue
 - reordered a comparison, be consistent when checking strcmp() return
   (Joe Perches, first two patches)

Laurentiu Tudor (15):
  staging: fsl-mc: move comparison before strcmp() call
  staging: fsl-mc: be consistent when checking strcmp() return
  staging: fsl-mc: drop useless #includes
  staging: fsl-mc: decouple the mc-bus public headers from dprc.h
  staging: fsl-mc: delete duplicated function prototypes
  staging: fsl-mc: delete prototype of unimplemented function
  staging: fsl-mc: turn several exported functions static
  staging: fsl-mc: move irq domain creation prototype to public header
  staging: fsl-mc: move couple of definitions to public header
  staging: fsl-mc: move rest of mc-bus.h to private header
  staging: fsl-mc: remove dpmng API files
  staging: fsl-mc: fix a few implicit includes
  staging: fsl-mc: move mc-sys.h contents in the public header
  staging: fsl-mc: move mc-cmd.h contents in the public header
  staging: fsl-mc: make dprc.h header private

 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |   1 -
 drivers/staging/fsl-dpaa2/ethernet/dpni.c          |   3 +-
 drivers/staging/fsl-mc/bus/Makefile                |   1 -
 drivers/staging/fsl-mc/bus/dpbp.c                  |   4 +-
 drivers/staging/fsl-mc/bus/dpcon.c                 |   4 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c             |   4 +-
 drivers/staging/fsl-mc/bus/dpmcp.c                 |   4 +-
 drivers/staging/fsl-mc/bus/dpmng.c                 |  74 --------
 drivers/staging/fsl-mc/bus/dprc-driver.c           |  54 +++---
 drivers/staging/fsl-mc/bus/dprc.c                  |   8 +-
 drivers/staging/fsl-mc/{include => bus}/dprc.h     |  46 +----
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c      |  11 +-
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c            |  71 +++++--
 drivers/staging/fsl-mc/bus/fsl-mc-msi.c            |   2 -
 drivers/staging/fsl-mc/bus/fsl-mc-private.h        |  64 ++++++-
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |   1 -
 drivers/staging/fsl-mc/bus/mc-io.c                 |   3 +-
 drivers/staging/fsl-mc/bus/mc-sys.c                |   2 -
 drivers/staging/fsl-mc/include/dpmng.h             |  67 -------
 drivers/staging/fsl-mc/include/mc-bus.h            | 111 -----------
 drivers/staging/fsl-mc/include/mc-cmd.h            | 130 -------------
 drivers/staging/fsl-mc/include/mc-sys.h            |  98 ----------
 drivers/staging/fsl-mc/include/mc.h                | 204 ++++++++++++++++++++-
 23 files changed, 371 insertions(+), 596 deletions(-)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpmng.c
 rename drivers/staging/fsl-mc/{include => bus}/dprc.h (84%)
 delete mode 100644 drivers/staging/fsl-mc/include/dpmng.h
 delete mode 100644 drivers/staging/fsl-mc/include/mc-bus.h
 delete mode 100644 drivers/staging/fsl-mc/include/mc-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/mc-sys.h

-- 
2.9.4
