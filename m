From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 21 Jun 2011 12:44:47 -0600
Subject: [PATCH 0/5] dt: Device creation infrastructure
Message-ID: <20110621181127.18176.1384.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds infrastructure for generating platform and amba
devices based on device tree data.  I intend to queue up this series
for the v3.1 merge window.  I had already posted these patches earlier
in the "Full device tree support for ARM Versatile" RFC series.  They
haven't changed since I posted that.

Unless I hear otherwise, I'll put the first 4 patches into
devicetree/next later this week.  The fifth patch can either go via
devicetree/next or benh's powerpc tree (your choice Ben).

g.

---

Grant Likely (5):
      dt: Add default match table for bus ids
      dt: add of_platform_populate() for creating device from the device tree
      drivers/amba: create devices from device tree
      dt/platform: allow device name to be overridden
      powerpc/5200: convert mpc5200 to use of_platform_populate()


 .../devicetree/bindings/arm/primecell.txt          |   21 ++
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   10 -
 drivers/of/platform.c                              |  196 +++++++++++++++++++-
 include/linux/of_platform.h                        |   40 ++++
 4 files changed, 252 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/primecell.txt
