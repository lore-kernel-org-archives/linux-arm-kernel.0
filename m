From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 07 Nov 2009 21:14:07 -0500 (EST)
Subject: Git pull request: Orion/Kirkwood fixes for 2.6.32-rc
Message-ID: <alpine.LFD.2.00.0911072104010.16711@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the for-rmk branch from:

	git://git.marvell.com/orion for-rmk

to receive a few fixes for 2.6.32-rc as well as defconfig updates for
Orion and Kirkwood.  Based on 2.6.32-rc6.

Lennert Buytenhek (3):
      [ARM] properly report mv78100 stepping A1
      [ARM] kirkwood: fix PCI I/O port assignment
      [ARM] Kirkwood: clarify PCIe MEM bus/physical address distinction

Li Jie (1):
      [ARM] kirkwood: fix section mismatch

Nicolas Pitre (2):
      [ARM] Kirkwood: update defconfig
      [ARM] orion5x: update defconfig

Simon Kagstrom (1):
      [ARM] OpenRD base: Initialize PCI express and i2c

 arch/arm/configs/kirkwood_defconfig            |  260 +++++++++++------
 arch/arm/configs/orion5x_defconfig             |  278 +++++++++++-------
 arch/arm/mach-kirkwood/addr-map.c              |    2 +-
 arch/arm/mach-kirkwood/common.c                |    2 +-
 arch/arm/mach-kirkwood/include/mach/io.h       |    2 +-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    1 +
 arch/arm/mach-kirkwood/openrd_base-setup.c     |   12 +
 arch/arm/mach-kirkwood/pcie.c                  |    6 +-
 arch/arm/mach-mv78xx0/common.c                 |    2 +
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h   |    1 +
 10 files changed, 367 insertions(+), 199 deletions(-)


Nicolas
