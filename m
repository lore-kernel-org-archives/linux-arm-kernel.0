From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 8 Mar 2013 17:32:49 -0500
Subject: [GIT PULL] ARM: mvebu: fixes for v3.9
Message-ID: <20130308223249.GW23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.9

for you to fetch changes up to b2d57222b0f0963258a47da0ea7f0ec451c64712:

  arm: mach-orion5x: fix typo in compatible string of a .dts file (2013-03-08 22:19:42 +0000)

----------------------------------------------------------------
mvebu fixes for v3.9

The first four patches:

  89c58c1 rtc: rtc-mv: Add support for clk to avoid lockups
  de88747 gpio: mvebu: Add clk support to prevent lockup
  7bf5b40 ARM: kirkwood: fix to retain gbe MAC addresses for DT kernels
  93fff4c ARM: kirkwood: of_serial: fix clock gating by removing clock-frequency

are Cc'd to stable since they were held over from the previous merge window.

The rest are a small collection of fixes and a couple of devicetree conversion
catchups.

----------------------------------------------------------------
Andrew Lunn (2):
      gpio: mvebu: Add clk support to prevent lockup
      rtc: rtc-mv: Add support for clk to avoid lockups

Florian Fainelli (1):
      arm: mvebu: enable the USB ports on Armada 370 Reference Design board

Heikki Krogerus (1):
      arm: mvebu: Reduce reg-io-width with UARTs

Jason Cooper (1):
      ARM: kirkwood: of_serial: fix clock gating by removing clock-frequency

Jean-Francois Moine (1):
      ARM: Dove: add RTC device node

Paul Bolle (1):
      ARM: dove: drop "select COMMON_CLK_DOVE"

Sebastian Hesselbarth (1):
      ARM: kirkwood: fix to retain gbe MAC addresses for DT kernels

Thomas Petazzoni (3):
      arm: plat-orion: fix address decoding when > 4GB is used
      arm: mvebu: fix address-cells in mpic DT node
      arm: mach-orion5x: fix typo in compatible string of a .dts file

 arch/arm/Kconfig                                   |  1 -
 arch/arm/boot/dts/armada-370-rd.dts                |  8 +++++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  5 ++--
 arch/arm/boot/dts/armada-xp.dtsi                   |  4 ++--
 arch/arm/boot/dts/dove.dtsi                        |  5 ++++
 arch/arm/boot/dts/kirkwood-dns320.dts              |  2 --
 arch/arm/boot/dts/kirkwood-dns325.dts              |  1 -
 arch/arm/boot/dts/kirkwood-dockstar.dts            |  1 -
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  1 -
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |  1 -
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |  1 -
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  1 -
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  1 -
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |  1 -
 arch/arm/boot/dts/kirkwood-lschlv2.dts             |  1 -
 arch/arm/boot/dts/kirkwood-lsxhl.dts               |  1 -
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  1 -
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  1 -
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  1 -
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  2 --
 arch/arm/boot/dts/kirkwood-topkick.dts             |  1 -
 arch/arm/boot/dts/kirkwood.dtsi                    |  5 ++--
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |  2 +-
 arch/arm/mach-kirkwood/board-dt.c                  | 25 +++++++++++++------
 arch/arm/plat-orion/addr-map.c                     |  7 ++++--
 drivers/gpio/gpio-mvebu.c                          |  7 ++++++
 drivers/rtc/rtc-mv.c                               | 28 ++++++++++++++++++----
 27 files changed, 75 insertions(+), 40 deletions(-)
