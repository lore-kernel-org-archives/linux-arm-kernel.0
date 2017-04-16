From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Apr 2017 12:00:03 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20170416190003.GA9865@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 0fa974b8b6106e053595e5481ef6fdbf5c60b457:

  Merge tag 'arm-soc/for-4.11/devicetree-arm64-fixes' of http://github.com/Broadcom/stblinux into fixes (2017-03-24 17:51:50 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to e2647b6de7247b8b8ed50da8d89138a1566c0293:

  Merge tag 'omap-for-v4.11/fixes-rc6-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2017-04-16 11:52:26 -0700)

----------------------------------------------------------------
ARM: SoC fixes

Again, a batch that's been sitting a couple of weeks, mostly because I
anticipated a bit more material but it didn't show up -- which is good.

These are all your garden variety fixes for ARM platforms. Most visible issue
fixed here is probably the SMP reset issue on OMAP, the rest are minor stuff.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: OMAP3: Fix MFG ID EEPROM

Arnd Bergmann (1):
      ARM: orion5x: only call into phylib when available

Dave Gerlach (1):
      ARM: OMAP2+: omap_device: Sync omap_device and pm_runtime after probe defer

Icenowy Zheng (1):
      arm64: allwinner: a64: add pmu0 regs for USB PHY

Olof Johansson (4):
      Merge tag 'reset-fixes-for-4.11-2' of git://git.pengutronix.de/git/pza/linux into fixes
      Merge tag 'sunxi-fixes-for-4.11-2' of https://git.kernel.org/.../sunxi/linux into fixes
      Merge tag 'mvebu-fixes-4.11-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'omap-for-v4.11/fixes-rc6-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Philipp Zabel (1):
      reset: add exported __reset_control_get, return NULL if optional

Quentin Schulz (2):
      ARM: sun8i: a33: remove highest OPP to fix CPU crashes
      ARM: sun8i: a33: add operating-points-v2 property to all nodes

Reizer, Eyal (1):
      ARM: dts: am335x-evmsk: adjust mmc2 param to allow suspend

Rob Herring (1):
      ARM: dts: ti: fix PCI bus dtc warnings

Tony Lindgren (1):
      ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot

Yegor Yefremov (1):
      ARM: dts: am335x-baltos: disable EEE for Atheros 8035 PHY

 arch/arm/boot/dts/am335x-baltos.dtsi          |  2 +
 arch/arm/boot/dts/am335x-evmsk.dts            |  1 +
 arch/arm/boot/dts/dra7.dtsi                   |  2 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi    |  2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi              | 12 ++--
 arch/arm/mach-omap2/common.h                  |  1 +
 arch/arm/mach-omap2/omap-hotplug.c            |  2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c     | 22 +++++--
 arch/arm/mach-omap2/omap-smc.S                |  1 -
 arch/arm/mach-omap2/omap-smp.c                | 90 ++++++++++++++++++++++-----
 arch/arm/mach-omap2/omap_device.c             |  8 +++
 arch/arm/mach-orion5x/Kconfig                 |  1 +
 arch/arm/plat-orion/common.c                  |  5 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  2 +
 drivers/reset/core.c                          | 22 +++++--
 include/linux/reset.h                         | 22 ++++---
 16 files changed, 154 insertions(+), 41 deletions(-)
