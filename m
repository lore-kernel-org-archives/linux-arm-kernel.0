From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 8 Jun 2017 15:57:08 -0500
Subject: [GIT PULL v2] updates to qbman (soc drivers) to support arm/arm64
Message-ID: <1496955428-17440-1-git-send-email-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: Removed the patches for MAINTAINERS file as they are already picked
up by powerpc tree.

Hi arm-soc maintainers,

As Scott has left NXP, he agreed to transfer the maintainership of
drivers/soc/fsl to me.  Previously most of the soc drivers were going
through the powerpc tree as they were only used/tested on Power-based
SoCs.  Going forward new changes will be mostly related to arm/arm64
SoCs, and I would prefer them to go through the arm-soc tree.

This pull request includes updates to the QMAN/BMAN drivers to make
them work on the arm/arm64 architectures in addition to the power
architecture.

DPAA (Data Path Acceleration Architecture) is a set of hardware
components used on some FSL/NXP QorIQ Networking SoCs, it provides the
infrastructure to support simplified sharing of networking interfaces
and accelerators by multiple CPU cores, and the accelerators
themselves.  The QMan(Queue Manager) and BMan(Buffer Manager) are
infrastructural components within the DPAA framework.  They are used to
manage queues and buffers for various I/O interfaces, hardware
accelerators.  

More information can be found via link: 
http://www.nxp.com/products/microcontrollers-and-processors/power-architecture-processors/qoriq-platforms/data-path-acceleration:QORIQ_DPAA

Regards,
Leo


The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git 

for you to fetch changes up to 35a875f231a254b7a65f8bed0c4bf4fc58586ea0:

  soc/fsl/qbman: Add missing headers on ARM (2017-06-08 15:11:00 -0500)

----------------------------------------------------------------
Claudiu Manoil (2):
      soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
      soc/fsl/qbman: Add missing headers on ARM

Madalin Bucur (3):
      soc/fsl/qbman: Drop set/clear_bits usage
      soc/fsl/qbman: define new revision QMAN_REV32
      soc/fsl/qbman: define register offsets on ARM/ARM64

Roy Pledge (4):
      soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
      soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
      dt-bindings: soc/fsl: Update reserved memory binding for QBMan
      soc/fsl/qbman: Use different ioremap() variants for ARM/PPC

Valentin Rothberg (1):
      soc/fsl/qbman: Fix CONFIG_ARM32 typo

 Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
 Documentation/devicetree/bindings/soc/fsl/qman.txt |  26 ++--
 drivers/soc/fsl/qbman/bman.c                       |  24 +++-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  35 +++++-
 drivers/soc/fsl/qbman/bman_portal.c                |  12 +-
 drivers/soc/fsl/qbman/bman_priv.h                  |   3 +
 drivers/soc/fsl/qbman/dpaa_sys.h                   |   8 +-
 drivers/soc/fsl/qbman/qman.c                       |  46 ++++++-
 drivers/soc/fsl/qbman/qman_ccsr.c                  | 140 ++++++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c                |  12 +-
 drivers/soc/fsl/qbman/qman_priv.h                  |   5 +-
 drivers/soc/fsl/qbman/qman_test.h                  |   2 -
 12 files changed, 261 insertions(+), 64 deletions(-)
