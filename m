From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 23 Feb 2011 13:44:07 -0500
Subject: [PATCH v4 0/4] davinci: add spi devices support for da8xx based
	platforms
Message-ID: <1298486651-18882-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds SPI bus support and devices for the MityDSP-L138,
MityARM-1808, da850 evm, and da830 evm platforms.  This patch series is 
against the staging tree at [1] as per Sekhar's instructions.

This series has been tested on the MityDSP-L138 platform.

[1] http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/next-for-kevin

---
changes since v3:
   -- first 5 patches of series are incorporated in [1] and not included 
      in this submission
   -- refactored common spi registration code into da8xx_register_spi
      routine, reducing effective lines of code for multiple platform
      support.

Michael Williamson (2):
  davinci: da8xx: add spi resources and registration routine
  davinci: add spi devices support for MityDSP-L138/MityARM-1808
    platform

Sekhar Nori (2):
  davinci: add spi devices support for da850/omap-l138/am18x evm
  davinci: add spi devices support for da830/omap-l137/am17x evm

 arch/arm/mach-davinci/board-da830-evm.c    |   67 ++++++++++++++++++
 arch/arm/mach-davinci/board-da850-evm.c    |   73 +++++++++++++++++++
 arch/arm/mach-davinci/board-mityomapl138.c |   84 ++++++++++++++++++++++
 arch/arm/mach-davinci/devices-da8xx.c      |  104 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    4 +
 5 files changed, 332 insertions(+), 0 deletions(-)
