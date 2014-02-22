From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 02:03:37 -0500
Subject: [GIT PULL] ARM: mvebu: watchdog driver changes for v3.15
Message-ID: <20140222070337.GA7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

This is a great series by Ezequiel extending the orion watchdog driver
to support the Armada 370 and XP SoCs.  Its been in -next almost a week
and does depend on the branch mvebu/irqchip-fixes up to
tags/irqchip-mvebu-fixes-3.14 which has already be taken by tglx.

This series has been Acked by Wim for going through the arm-soc tree so
that we can manage the irqchip dependency.

Please pull.

thx,

Jason.


The following changes since commit d86e9af6336c0ad586a5dbd70064253d40bbb5ff:

  irqchip: orion: Fix getting generic chip pointer. (2014-02-21 21:46:56 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-watchdog-3.15

for you to fetch changes up to 59416745bb8cbe32daf805f768418353168b0664:

  watchdog: orion: Enable the build on ARCH_MVEBU (2014-02-22 03:44:34 +0000)

----------------------------------------------------------------
mvebu watchdog driver changes for v3.15

 - orion watchdog
    - cleanup and extend driver to support Armada 370 and Armada XP

Depends:
 - tags/irqchip-mvebu-fixes-3.14 (already pulled by tglx)
    - both are based on v3.14-rc1

----------------------------------------------------------------
Ezequiel Garcia (13):
      watchdog: orion: Add clock error handling
      watchdog: orion: Use atomic access for shared registers
      watchdog: orion: Remove unused macros
      watchdog: orion: Make sure the watchdog is initially stopped
      watchdog: orion: Handle the interrupt so it's properly acked
      watchdog: orion: Make RSTOUT register a separate resource
      watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
      watchdog: orion: Introduce an orion_watchdog device structure
      watchdog: orion: Introduce per-compatible of_device_id data
      watchdog: orion: Add per-compatible clock initialization
      watchdog: orion: Add per-compatible watchdog start implementation
      watchdog: orion: Add support for Armada 370 and Armada XP SoC
      watchdog: orion: Enable the build on ARCH_MVEBU

 .../devicetree/bindings/watchdog/marvel.txt        |  11 +-
 arch/arm/mach-dove/include/mach/bridge-regs.h      |   1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   1 +
 arch/arm/plat-orion/common.c                       |  10 +-
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/orion_wdt.c                       | 381 ++++++++++++++++-----
 8 files changed, 322 insertions(+), 86 deletions(-)
