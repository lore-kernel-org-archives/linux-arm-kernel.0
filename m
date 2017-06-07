From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Jun 2017 21:18:40 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20170607041840.GA3213@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git armsoc-fixes

for you to fetch changes up to 151d1d752bb681f29898c68c966f6e17b446456c:

  MAINTAINERS: EP93XX: Update maintainership (2017-06-06 21:07:37 -0700)

----------------------------------------------------------------
ARM: SoC fixes

Been sitting on these for a couple of weeks waiting on some larger batches
to come in but it's been pretty quiet.

Just your garden variety fixes here:

 - A few maintainers updates (ep93xx, Exynos, TI, Marvell)
 - Some PM fixes for Atmel/at91 and Marvell
 - A few DT fixes for Marvell, Versatile, TI Keystone, bcm283x
 - A reset driver patch to set module license for symbol access

----------------------------------------------------------------
Alexander Sverdlin (1):
      MAINTAINERS: EP93XX: Update maintainership

Antoine Tenart (1):
      arm64: marvell: dts: fix interrupts in 7k/8k crypto nodes

Arnd Bergmann (2):
      memory: atmel-ebi: mark PM ops as __maybe_unused
      ARM: at91: select CONFIG_ARM_CPU_SUSPEND

Christophe JAILLET (2):
      ARM: davinci: PM: Free resources in error handling path in 'davinci_pm_init'
      ARM: davinci: PM: Do not free useful resources in normal path in 'davinci_pm_init'

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-fixes-2017-05-16' into devicetree/fixes

Heiko Stuebner (1):
      arm64: defconfig: enable some core options for 64bit Rockchip socs

Javier Martinez Canillas (1):
      MAINTAINERS: Remove Javier Martinez Canillas as reviewer for Exynos

Jeremy Linton (1):
      reset: hi6220: Set module license so that it can be loaded

Masahiro Yamada (1):
      ARM: dts: versatile: use #include "..." to include local DT

Murali Karicheri (1):
      ARM: dts: keystone-k2l: fix broken Ethernet due to disabled OSR

Olof Johansson (8):
      Merge tag 'davinci-fixes-for-v4.12' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'arm-soc/for-4.12/devicetree-fixes-2' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'samsung-fixes-4.12' of git://git.kernel.org/.../krzk/linux into fixes
      Merge tag 'at91-4.12-fixes' of git://git.kernel.org/.../abelloni/linux into fixes
      Merge tag 'reset-fixes-for-4.12' of git://git.pengutronix.de/git/pza/linux into fixes
      Merge tag 'mvebu-fixes-4.12-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'mvebu-fixes-non-critical-4.12-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'davinci-fixes-for-v4.12-p2' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes

Patrice Chotard (1):
      MAINTAINERS: remove kernel at stlinux.com obsolete mailing list

Phil Elwell (1):
      ARM: dts: bcm283x: Reserve first page for firmware

Sekhar Nori (1):
      MAINTAINERS: add device-tree files to TI DaVinci entry

Thomas Petazzoni (2):
      MAINTAINERS: sort F entries for Marvell EBU maintainers
      MAINTAINERS: add irqchip related drivers to Marvell EBU maintainers

 MAINTAINERS                                          | 14 +++++++-------
 arch/arm/boot/dts/bcm283x.dtsi                       |  5 +++++
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi            |  4 ++--
 arch/arm/boot/dts/keystone-k2l.dtsi                  |  8 ++++++++
 arch/arm/boot/dts/versatile-pb.dts                   |  2 +-
 arch/arm/mach-at91/Kconfig                           |  1 +
 arch/arm/mach-davinci/pm.c                           |  7 ++++++-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi |  3 +--
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  3 +--
 arch/arm64/configs/defconfig                         | 10 ++++++++++
 drivers/memory/atmel-ebi.c                           |  2 +-
 drivers/reset/hisilicon/hi6220_reset.c               |  2 ++
 12 files changed, 45 insertions(+), 16 deletions(-)
