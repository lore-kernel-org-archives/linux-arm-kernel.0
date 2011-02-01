From: michael.williamson@criticallink.com (Michael Williamson)
Date: Mon, 31 Jan 2011 19:05:12 -0500
Subject: [PATCH 0/4] davinci: Add SPI support for da8xx platforms
Message-ID: <1296518716-5004-1-git-send-email-michael.williamson@criticallink.com>
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

The patch series is against commit 8fb837c158e342413d08d6f211b5b8f67d5adc2f
of kevin's tree.

[1] http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite

Michael Williamson (2):
  davinci: da8xx/omap-l1: add support for SPI
  davinci: add spi devices support for MityDSP-L138/MityARM-1808
    platform

Sekhar Nori (2):
  davinci: add spi devices support for da850/omap-l138/am18x evm
  davinci: add spi devices support for da830/omap-l137/am17x evm

 arch/arm/mach-davinci/board-da830-evm.c    |   82 ++++++++++++++++++++++
 arch/arm/mach-davinci/board-da850-evm.c    |   88 +++++++++++++++++++++++
 arch/arm/mach-davinci/board-mityomapl138.c |  104 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c              |   16 ++++
 arch/arm/mach-davinci/devices-da8xx.c      |   88 +++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 6 files changed, 380 insertions(+), 0 deletions(-)
