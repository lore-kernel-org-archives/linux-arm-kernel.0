From: roy.pledge@nxp.com (Roy Pledge)
Date: Tue, 30 Oct 2018 20:30:34 +0000
Subject: [PATCH v1 0/2] soc: fsl: dpio: Add support for memory backed QBMan
 portals
Message-ID: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for QBMan memory backed portals which is
avaialble in devices containing QBMan verion 5.0 and above (for example
NXP's LX2160A SoC).

Memory backed portals can be mapped as normal cacheable/shareable memory which
allows the portals to migrate between cores without needing manual cache
manipulations by the CPU.

The patches add support for the new portal attributes in the fsl-mc bus drivers
as well as modifying the QBMan driver to use the new portal read trigger
mechanism.

Roy Pledge (2):
  bus: mc-bus: Add support for mapping shareable portals
  soc: fsl: dpio: Add support for memory backed QBMan portals

 drivers/bus/fsl-mc/dprc.c           |   3 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c     |  14 +++-
 drivers/bus/fsl-mc/fsl-mc-private.h |  17 ++++-
 drivers/soc/fsl/dpio/dpio-driver.c  |  23 ++++--
 drivers/soc/fsl/dpio/qbman-portal.c | 148 ++++++++++++++++++++++++++++++------
 drivers/soc/fsl/dpio/qbman-portal.h |   5 ++
 6 files changed, 172 insertions(+), 38 deletions(-)

--
2.7.4
