From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Mar 2017 10:07:23 -0700
Subject: [GIT PULL] omap fixes for v4.11-rc cycle
Message-ID: <pull-1490807222-802520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e24bce8fb4c26bd0d8eca74cbbee1ad049246be3:

  Merge tag 'v4.11-rc1' into omap-for-v4.11/fixes (2017-03-06 08:37:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-rc4

for you to fetch changes up to 351b7c490700747d1dba1b0a10fbfe3448d11c35:

  ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot (2017-03-27 10:10:42 -0700)

----------------------------------------------------------------
Fixes for omaps for v4.11-rc cycle. The biggest fix is to stop doing
unconditional reset of CPU1 as that caused a regression for cases with
custom bootloader loaded code running on CPU1. The rest are just minor
fixes for devices and one warning fix.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: OMAP3: Fix MFG ID EEPROM

Reizer, Eyal (1):
      ARM: dts: am335x-evmsk: adjust mmc2 param to allow suspend

Rob Herring (1):
      ARM: dts: ti: fix PCI bus dtc warnings

Tony Lindgren (1):
      ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot

Yegor Yefremov (1):
      ARM: dts: am335x-baltos: disable EEE for Atheros 8035 PHY

 arch/arm/boot/dts/am335x-baltos.dtsi       |  2 +
 arch/arm/boot/dts/am335x-evmsk.dts         |  1 +
 arch/arm/boot/dts/dra7.dtsi                |  2 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi |  2 +-
 arch/arm/mach-omap2/common.h               |  1 +
 arch/arm/mach-omap2/omap-hotplug.c         |  2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c  | 22 ++++++--
 arch/arm/mach-omap2/omap-smc.S             |  1 -
 arch/arm/mach-omap2/omap-smp.c             | 90 +++++++++++++++++++++++++-----
 9 files changed, 102 insertions(+), 21 deletions(-)
