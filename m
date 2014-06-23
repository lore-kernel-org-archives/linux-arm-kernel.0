From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:34 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v3.17
Message-ID: <cover.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v3.17.


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-dt-for-v3.17

for you to fetch changes up to 09abd1fd11f98d6abde9c23244234170e7e36c2f:

  ARM: shmobile: r8a7791: add R-Car sound support on DTSI (2014-06-17 19:58:32 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v3.17

Increased hardware coverage:
* Add R-Car sounds support to r8a7790 SoC
* Add PCIe support to r8a7790 and r8a7791 SoCs
* Increase I2C support of Henninger and lager boards
* DVFS support to Koelsch board
* Add SYS-DMAC clocks to r8a7791 SoCs
* Add USB 3.0 clocks to r8a7791 and r8a7790 SoCs
* Add LED labels to armadillo800eva board

Cleanup:
* Remove early_printk from marzen command line

----------------------------------------------------------------
Ben Dooks (2):
      ARM: shmobile: lager: enable i2c devices
      ARM: shmobile: lager: add i2c1, i2c2 pins

Benoit Cousson (2):
      ARM: shmobile: lager: Add VDD MPU regulator for DVFS
      ARM: shmobile: r8a7790/lager dts: Add DVFS parameters into cpu0 node for r8a7790

Gaku Inami (2):
      ARM: shmobile: koelsch dts: Add VDD MPU regulator for DVFS
      ARM: shmobile: r8a7791/koelsch dts: Add DVFS parameters into cpu0 node for r8a7791

Geert Uytterhoeven (2):
      ARM: shmobile: armadillo800eva reference dts: Add matching LED labels
      ARM: shmobile: r8a7791 dtsi: add SYS-DMAC clocks

Kuninori Morimoto (5):
      ARM: shmobile: r8a7790: add MSTP10 support on DTSI
      ARM: shmobile: r8a7790: add R-Car sound support on DTSI
      ARM: shmobile: r8a7791: add audio clock on DTSI
      ARM: shmobile: r8a7791: add MSTP10 support on DTSI
      ARM: shmobile: r8a7791: add R-Car sound support on DTSI

Magnus Damm (1):
      ARM: shmobile: Lager memory map update

Phil Edworthy (8):
      ARM: shmobile: r8a7790: Add PCIEC clock device tree node
      ARM: shmobile: r8a7790: Add default PCIe bus clock
      ARM: shmobile: r8a7790: Add PCIe Controller device node
      ARM: shmobile: r8a7791: Add PCIEC clock device tree node
      ARM: shmobile: r8a7791: Add default PCIe bus clock
      ARM: shmobile: r8a7791: Add PCIe Controller device node
      ARM: shmobile: koelsch: Enable PCIe Controller & PCIe bus clock
      ARM: shmobile: henninger: Enable PCIe Controller & PCIe bus clock

Sergei Shtylyov (1):
      ARM: shmobile: henninger: add I2C2 DT support

Simon Horman (4):
      ARM: shmobile: marzen: Remove early_printk from command line
      ARM: shmobile: lager: Move i2c[12]_pins nodes to pfc node
      ARM: shmobile: lager: Remove duplicate i2c3 nodes
      ARM: shmobile: koelsch: Remove duplicate i2c6 nodes

Yoshihiro Shimoda (2):
      ARM: shmobile: r8a7790: add USB3.0 clocks to device tree
      ARM: shmobile: r8a7791: add USB3.0 clocks to device tree

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  12 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   2 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |  55 ++++++-
 arch/arm/boot/dts/r8a7790.dtsi                     | 140 ++++++++++++++++-
 arch/arm/boot/dts/r8a7791-henninger.dts            |  21 +++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  67 +++++---
 arch/arm/boot/dts/r8a7791.dtsi                     | 171 ++++++++++++++++++++-
 include/dt-bindings/clock/r8a7790-clock.h          |  27 ++++
 include/dt-bindings/clock/r8a7791-clock.h          |  27 ++++
 9 files changed, 488 insertions(+), 34 deletions(-)
