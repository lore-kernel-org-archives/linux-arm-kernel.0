From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Oct 2010 23:20:19 -0400 (EDT)
Subject: Git pull request: Kirkwood updates for next merge window
Message-ID: <alpine.LFD.2.00.1010112314010.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull:

	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git

This contains a few updates to Kirkwood supported targets.

Eric Cooper (1):
      [ARM] Kirkwood: support for Seagate DockStar

Simon Guinot (5):
      [ARM] Kirkwood: add LaCie d2 Network v2 support
      [ARM] Kirkwood: remove duplicated code in LaCie setup files
      leds: leds-ns2: fix private driver data storage
      leds: add LED driver for Big Network series LEDs
      [ARM] Kirkwood: add LED support for netxbig_v2 boards

Tanmay Upadhyay (1):
      [ARM] OpenRD: Enable SD/UART selection for serial port 1

 arch/arm/configs/kirkwood_defconfig                |    1 +
 arch/arm/mach-kirkwood/Kconfig                     |   12 +
 arch/arm/mach-kirkwood/Makefile                    |   12 +-
 arch/arm/mach-kirkwood/d2net_v2-setup.c            |  231 +++++++
 arch/arm/mach-kirkwood/dockstar-setup.c            |  112 ++++
 arch/arm/mach-kirkwood/include/mach/leds-netxbig.h |   55 ++
 arch/arm/mach-kirkwood/lacie_v2-common.c           |  127 ++++
 arch/arm/mach-kirkwood/lacie_v2-common.h           |   18 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c         |  122 +----
 arch/arm/mach-kirkwood/netxbig_v2-setup.c          |  269 ++++----
 arch/arm/mach-kirkwood/openrd-setup.c              |  101 +++-
 drivers/leds/Kconfig                               |   11 +-
 drivers/leds/Makefile                              |    1 +
 drivers/leds/leds-netxbig.c                        |  449 ++++++++++++++
 drivers/leds/leds-ns2.c                            |    9 +-
 15 files changed, 1277 insertions(+), 253 deletions(-)
