From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed,  9 Feb 2011 08:11:48 -0500
Subject: [PATCH v2 0/6] davinci: Add SPI support for da8xx platforms
Message-ID: <1297257114-764-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the necessary SPI resources and registration
routines for da850/OMAP-L138/AM18x and da830/OMAP-L137/AM17x devices.
It also adds on-board SPI FLASH devices for the da830 evm, the da850
evm, and the MityDSP-L138/MityARM-1808 platforms.

These patches are based on work done during testing of davinci SPI driver
submissions incorporated in version 2.6.38 of the kernel, at [1].

The da850 and da830 EVM portions of this patch need verification / ack.

The MityDSP-L138 platform patch has been tested.

The patch series is against linux-davinci tree, but is dependent on the 
patches [2] (approved, but not applied) and [3] (submitted 2/3/2011), which 
were generated as a result of initial review of this series.

[1] http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite
[2] https://patchwork.kernel.org/patch/540831/
[3] https://patchwork.kernel.org/patch/530471/

---
Changes since v1:
   - move event queue parameter to platform data structures
   - move magic numbers to #defines
   - rename da830 spi clock name to match driver
   - clarify patch description for resource additions per comments

Michael Williamson (4):
  davinci: da830: fix driver name for spi clocks
  davinci: da850: add spi device clock definitions
  davinci: da8xx: add spi resources and registration routine
  davinci: add spi devices support for MityDSP-L138/MityARM-1808
    platform

Sekhar Nori (2):
  davinci: add spi devices support for da850/omap-l138/am18x evm
  davinci: add spi devices support for da830/omap-l137/am17x evm

 arch/arm/mach-davinci/board-da830-evm.c    |   78 ++++++++++++++++++++++
 arch/arm/mach-davinci/board-da850-evm.c    |   84 +++++++++++++++++++++++
 arch/arm/mach-davinci/board-mityomapl138.c |  100 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da830.c              |    4 +-
 arch/arm/mach-davinci/da850.c              |   16 +++++
 arch/arm/mach-davinci/devices-da8xx.c      |   98 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 +
 7 files changed, 381 insertions(+), 2 deletions(-)
