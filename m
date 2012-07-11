From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 14:36:22 +0100
Subject: [PATCH 0/9] Versatile Express updates for 3.6
Message-ID: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series is a set of updates of Versatile Express code I'd like
to get into 3.6 window. If there are no issues I'll create a v3.5-rc6
based branch and ask Arnd and/or Olof to pull it by the end of this
week.

There's nothing revolutionary here, really. The common clock change
has been posted already over a month ago and lives happily in the
Linaro's kernel tree since.

One note - the "Make plat-versatile clock optional" simply replicates
part of Linus Walleij's "Integrator common clock" patch and can be
dropped if one has this change already pulled in.

Regards

Pawel

Pawel Moll (8):
  ARM: vexpress: Check master site in daughterboard's sysctl operations
  ARM: versatile: Make plat-versatile clock optional
  ARM: vexpress: Initial common clock support
  ARM: vexpress: Add missing SP804 interrupt in motherboard's DTS files
  ARM: vexpress: Add fixed regulator for SMSC
  ARM: vexpress: Convert V2P-CA15 Device Tree to 64 bit addresses
  ARM: vexpress: Add Device Tree for V2P-CA15_CA7 core tile
  ARM: vexpress: Config option for early printk console

Will Deacon (1):
  ARM: vexpress: remove automatic errata workaround selection

 arch/arm/Kconfig                                  |    6 +-
 arch/arm/Kconfig.debug                            |   26 ++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi           |   11 +
 arch/arm/boot/dts/vexpress-v2m.dtsi               |   11 +
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts       |   36 +--
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts        |  188 +++++++++++++
 arch/arm/configs/vexpress_defconfig               |   25 +-
 arch/arm/mach-vexpress/Kconfig                    |   13 -
 arch/arm/mach-vexpress/Makefile.boot              |    3 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   64 ++---
 arch/arm/mach-vexpress/include/mach/clkdev.h      |   15 --
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   44 ++++
 arch/arm/mach-vexpress/include/mach/motherboard.h |   28 +-
 arch/arm/mach-vexpress/include/mach/uncompress.h  |   14 +
 arch/arm/mach-vexpress/v2m.c                      |  292 ++++++++++-----------
 arch/arm/plat-versatile/Kconfig                   |    3 +
 arch/arm/plat-versatile/Makefile                  |    2 +-
 17 files changed, 512 insertions(+), 269 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
 delete mode 100644 arch/arm/mach-vexpress/include/mach/clkdev.h

-- 
1.7.9.5
