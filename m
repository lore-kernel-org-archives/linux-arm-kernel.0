From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 May 2011 18:04:33 -0400 (EDT)
Subject: Git pull request: consolidation of orion alike platforms
Message-ID: <alpine.LFD.2.00.1105161800240.14430@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following:

	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git

This contains consolidation work to be merged for the next merge window.
It is based on commit cfefd21 "genirq: Add chip suspend and resume
callbacks" from Thomas which appears to be in your devel-stable branch.

Net amount of lines removed is 1302.

Andrew Lunn (15):
      ARM: orion: Rename some constants to macros to make code more identical
      ARM: orion: Consolidate the creation of the uart platform data.
      ARM: orion: Consolidate the creation of the RTC platform data.
      ARM: kirkwood: Add support for RTC interrupts which allows RTC alarms.
      ARM: orion: Consolidate ethernet platform data
      ARM: orion: Consolidate I2C initialization.
      ARM: orion: Consolidate SPI initialization.
      ARM: orion: Consolidate the platform data setup for the watchdog.
      ARM: orion: Consolidate the XOR platform setup code.
      ARM: orion: Consolidate USB platform setup code.
      ARM: orion: Consolidate SATA platform setup.
      ARM: orion: Consolidate setup of the crypto engine.
      ARM: orion: Refactor the MPP code common in the orion platform
      ARM: orion5x: Refactor mpp code to use common orion platform mpp.
      ARM: dove: Consolidate mpp code with platform mpp.

Thomas Gleixner (1):
      arm: orion: Use generic irq chip

 arch/arm/mach-dove/common.c                    |  616 +-----------
 arch/arm/mach-dove/mpp.c                       |  134 +--
 arch/arm/mach-dove/mpp.h                       |  362 +++----
 arch/arm/mach-kirkwood/common.c                |  601 +-----------
 arch/arm/mach-kirkwood/include/mach/irqs.h     |    1 +
 arch/arm/mach-kirkwood/mpp.c                   |   58 +-
 arch/arm/mach-kirkwood/mpp.h                   |    6 -
 arch/arm/mach-loki/common.c                    |  190 +----
 arch/arm/mach-mv78xx0/common.c                 |  570 +----------
 arch/arm/mach-mv78xx0/mpp.c                    |   58 +-
 arch/arm/mach-mv78xx0/mpp.h                    |    6 -
 arch/arm/mach-orion5x/common.c                 |  478 +--------
 arch/arm/mach-orion5x/d2net-setup.c            |   44 +-
 arch/arm/mach-orion5x/db88f5281-setup.c        |   44 +-
 arch/arm/mach-orion5x/dns323-setup.c           |  132 ++--
 arch/arm/mach-orion5x/edmini_v2-setup.c        |   44 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c      |   44 +-
 arch/arm/mach-orion5x/ls-chl-setup.c           |   44 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c           |   44 +-
 arch/arm/mach-orion5x/lsmini-setup.c           |   44 +-
 arch/arm/mach-orion5x/mpp.c                    |  150 +---
 arch/arm/mach-orion5x/mpp.h                    |  191 +++--
 arch/arm/mach-orion5x/mss2-setup.c             |   44 +-
 arch/arm/mach-orion5x/mv2120-setup.c           |   44 +-
 arch/arm/mach-orion5x/net2big-setup.c          |   44 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |   44 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |   44 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c        |   44 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    1 -
 arch/arm/mach-orion5x/terastation_pro2-setup.c |   44 +-
 arch/arm/mach-orion5x/ts209-setup.c            |   44 +-
 arch/arm/mach-orion5x/ts409-setup.c            |   44 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |   44 +-
 arch/arm/mach-orion5x/wnr854t-setup.c          |   44 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |   44 +-
 arch/arm/plat-orion/Makefile                   |    2 +-
 arch/arm/plat-orion/common.c                   |  957 ++++++++++++++++++
 arch/arm/plat-orion/gpio.c                     |  112 +--
 arch/arm/plat-orion/include/plat/common.h      |  117 +++
 arch/arm/plat-orion/include/plat/gpio.h        |    1 -
 arch/arm/plat-orion/include/plat/mpp.h         |   34 +
 arch/arm/plat-orion/irq.c                      |   49 +-
 arch/arm/plat-orion/mpp.c                      |   78 ++
 43 files changed, 2219 insertions(+), 3521 deletions(-)
