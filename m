From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 12 Jul 2012 16:39:35 +0100
Subject: [GIT PULL] Veratile Express updates for v3.6
Message-ID: <1342107575.25865.13.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Ofof,

Could you, please, pull the updated for Versatile Express based on
v3.5-rc6? You may want to drop the "Make plat-versatile clock optional"
during the merge, if it conflicts with Intergrator's common clock change
(shouldn't be a problem, though).

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-v3.5-rc6

for you to fetch changes up to 5d4b9fa0cac57e73857e2dd6d116ef98ef1109b5:

  ARM: vexpress: Config option for early printk console (2012-07-12 16:16:58 +0100)

Thanks!

Pawel

----------------------------------------------------------------
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
 arch/arm/mach-vexpress/Kconfig                    |    5 +-
 arch/arm/mach-vexpress/Makefile.boot              |    3 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   64 ++---
 arch/arm/mach-vexpress/include/mach/clkdev.h      |   15 --
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   41 +++
 arch/arm/mach-vexpress/include/mach/motherboard.h |   28 +-
 arch/arm/mach-vexpress/include/mach/uncompress.h  |   14 +
 arch/arm/mach-vexpress/v2m.c                      |  292 ++++++++++-----------
 arch/arm/plat-versatile/Kconfig                   |    3 +
 arch/arm/plat-versatile/Makefile                  |    2 +-
 16 files changed, 504 insertions(+), 241 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
 delete mode 100644 arch/arm/mach-vexpress/include/mach/clkdev.h
