From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 22 Feb 2011 08:36:55 -0500
Subject: [PATCH v3 0/9] davinci: Add spi support for da8xx platforms
Message-ID: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the necessary SPI resources and registration
routines for da850/OMAP-L138/AM18x and da830/OMAP-L137/AM17x devices.

It removes some unused enumerations related to the DMA channels
for the da830 platform as a result of initial reviews of the patch
series.

It moves the event queue number for the SPI DMA control out of
the resources array and into the platform data structure passed to
the davinci spi driver.

It adds on-board SPI FLASH devices for the da830 evm, the da850
evm, and the MityDSP-L138/MityARM-1808 platforms.

These patches are based on work done during testing of davinci SPI driver
submissions incorporated in version 2.6.38 of the kernel, at [1].

This patch series has been tested using a MityDSP-L138 platform, 
and the da850 and da830 EVMs.

The patch series is against linux-davinci tree.  The davinci spi driver
portion of this patch has been reviewed by the spi list and Acked
by Grant with the agreement to submit through linux-davinci tree.

[1] http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite

---
Changes since v2:
   - combined previously approved / Acked patches into this 
     patch series per request from maintainer.
   - fixed whitespace issue identified by checkpatch
   - added function name for warning tracing per comments

Michael Williamson (7):
  davinci: remove unused DA830_edma_ch enum
  davinci: da8xx: clean up magic numbers in devices-da8xx.c
  davinci: spi: move event queue parameter to platform data
  davinci: da830: fix driver name for spi clocks
  davinci: da850: add spi device clock definitions
  davinci: da8xx: add spi resources and registration routine
  davinci: add spi devices support for MityDSP-L138/MityARM-1808
    platform

Sekhar Nori (2):
  davinci: add spi devices support for da850/omap-l138/am18x evm
  davinci: add spi devices support for da830/omap-l137/am17x evm

 arch/arm/mach-davinci/board-da830-evm.c    |   80 +++++++++++++++++++
 arch/arm/mach-davinci/board-da850-evm.c    |   86 ++++++++++++++++++++
 arch/arm/mach-davinci/board-mityomapl138.c |  100 +++++++++++++++++++++++
 arch/arm/mach-davinci/da830.c              |    4 +-
 arch/arm/mach-davinci/da850.c              |   16 ++++
 arch/arm/mach-davinci/devices-da8xx.c      |  119 ++++++++++++++++++++++++++--
 arch/arm/mach-davinci/dm355.c              |    5 +-
 arch/arm/mach-davinci/dm365.c              |    5 +-
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 +
 arch/arm/mach-davinci/include/mach/edma.h  |   36 ---------
 arch/arm/mach-davinci/include/mach/spi.h   |   15 +++-
 drivers/spi/davinci_spi.c                  |   11 +--
 12 files changed, 413 insertions(+), 67 deletions(-)
