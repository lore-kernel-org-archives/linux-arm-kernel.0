From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 29 May 2018 22:39:15 +0300
Subject: [PATCH 0/2] PCI: Initial imx7d pm support
Message-ID: <cover.1527621510.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds initial pm support on imx7d so that after
suspend/resume lspci works again. This mostly copies the resume sequence
from the imx tree.

More can be done later to reduce power in suspend as well as adding
support for other socs.

This is motivated mostly by a desire to bring imx PM code closer to
upstream. It is possible that I am missing some things about how PM
should be done for pci host drivers, it would be great if you could
point me the right way.

It also relies on this bugfix for PGC offsets:
    https://lkml.org/lkml/2018/5/29/138
Without that patch resume hangs on first PCI read from PCI-PM core. It
is not strictly related to PCI but pci-imx6 is the only user of gpcv2
power domains.

Patch 1 in this series is also technically an unrelated bugfix, however
pci-imx6 is the only user.

Leonard Crestez (2):
  reset: imx7: Fix always writing bits as 0
  PCI: imx: Initial imx7d pm support

 drivers/pci/dwc/pci-imx6.c | 94 ++++++++++++++++++++++++++++++++++++--
 drivers/reset/reset-imx7.c |  2 +-
 2 files changed, 90 insertions(+), 6 deletions(-)

-- 
2.17.0
