From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 13 Dec 2011 16:18:38 -0500 (EST)
Subject: Git pull request: update to the Marvell Orion SOC family
Message-ID: <alpine.LFD.2.02.1112131611320.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys, please pull the following:

	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git

This contains minor fixes plus initial consolidation toward DT support.

Andrew Lunn (4):
      Consolidate the address map setup on Orion based platforms.
      Move the *_mbus_dram_info structure into the orion platform and call it orion_mbus_dram_info everywhere.
      Get address map from plat-orion instead of via platform_data.
      Remove address map info from all platform data strucutures.

Arnaud Patard (1):
      kirkwood: Add configuration for MPP12 as GPIO

Martin Michlmayr (1):
      kirkwood: Recognize A1 revision of 6282 chip

 arch/arm/mach-dove/addr-map.c                  |  121 +++++--------
 arch/arm/mach-dove/common.c                    |   16 +-
 arch/arm/mach-dove/common.h                    |    1 -
 arch/arm/mach-dove/pcie.c                      |    4 +-
 arch/arm/mach-kirkwood/addr-map.c              |  137 ++++----------
 arch/arm/mach-kirkwood/common.c                |   19 +-
 arch/arm/mach-kirkwood/common.h                |    1 -
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    1 +
 arch/arm/mach-kirkwood/mpp.c                   |    1 -
 arch/arm/mach-kirkwood/mpp.h                   |    1 +
 arch/arm/mach-kirkwood/pcie.c                  |    4 +-
 arch/arm/mach-mv78xx0/addr-map.c               |  102 ++---------
 arch/arm/mach-mv78xx0/common.c                 |   22 +--
 arch/arm/mach-mv78xx0/common.h                 |    1 -
 arch/arm/mach-mv78xx0/mpp.c                    |    1 -
 arch/arm/mach-mv78xx0/pcie.c                   |    4 +-
 arch/arm/mach-orion5x/addr-map.c               |  146 +++++----------
 arch/arm/mach-orion5x/common.c                 |   23 +--
 arch/arm/mach-orion5x/common.h                 |    3 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h   |    2 +-
 arch/arm/mach-orion5x/mpp.c                    |    1 -
 arch/arm/mach-orion5x/pci.c                    |    5 +-
 arch/arm/plat-orion/Makefile                   |    2 +-
 arch/arm/plat-orion/addr-map.c                 |  174 ++++++++++++++++++
 arch/arm/plat-orion/common.c                   |   43 +----
 arch/arm/plat-orion/include/plat/addr-map.h    |   53 ++++++
 arch/arm/plat-orion/include/plat/audio.h       |    3 -
 arch/arm/plat-orion/include/plat/common.h      |   17 +--
 arch/arm/plat-orion/include/plat/ehci-orion.h  |    1 -
 arch/arm/plat-orion/include/plat/mv_xor.h      |    6 -
 arch/arm/plat-orion/include/plat/mvsdio.h      |    1 -
 arch/arm/plat-orion/include/plat/pcie.h        |    3 +-
 arch/arm/plat-orion/pcie.c                     |    6 +-
 drivers/ata/sata_mv.c                          |   19 +-
 drivers/dma/mv_xor.c                           |   11 +-
 drivers/mmc/host/mvsdio.c                      |   13 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c     |   10 +-
 drivers/usb/host/ehci-orion.c                  |   10 +-
 include/linux/ata_platform.h                   |    3 -
 include/linux/mbus.h                           |   13 ++-
 sound/soc/kirkwood/kirkwood-dma.c              |   15 +-
 41 files changed, 497 insertions(+), 522 deletions(-)


Nicolas
