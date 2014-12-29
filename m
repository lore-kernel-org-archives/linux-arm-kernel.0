From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:44:01 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v3.20
Message-ID: <cover.1419812185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v3.20.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.20

for you to fetch changes up to 7408d3061d2f04181820902fae6e92e4a73d5cc0:

  ARM: shmobile: r8a7791: add MLB+ clock (2014-12-23 09:18:23 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v3.20

* Use clock-indices instead of deprecated renesas,clock-indices
* Prepare for r8a73a4 multiplatform support
* Increase clock coverage for r8a779[014]
* Correct r8a7779 clock usage
* Correct LAN9220 VDDVARIO voltage on ape6evm
* Correct QSPI SPI-Flash mode of lager and koelsch
* Correct flash partition label and size on koelsch
* Correct mask for GIC PPI interrupts on r8a779[14]
* Correct BSC bus range on ape6evm-reference

----------------------------------------------------------------
Andrey Gusakov (2):
      ARM: shmobile: r8a7790: add MLB+ clock
      ARM: shmobile: r8a7791: add MLB+ clock

Ben Dooks (2):
      ARM: shmobile: r8a7790 dtsi: Change to using clock-indices
      ARM: shmobile: r8a7791 dtsi: Change to using clock-indices

Geert Uytterhoeven (6):
      ARM: shmobile: ape6evm-reference: Correct BSC bus range
      ARM: shmobile: r8a7740 dtsi: Change to using clock-indices
      ARM: shmobile: r8a7779 dtsi: Change to using clock-indices
      ARM: shmobile: r8a7794 dtsi: Change to using clock-indices
      ARM: shmobile: r8a7791: Correct mask for GIC PPI interrupts
      ARM: shmobile: r8a7794: Correct mask for GIC PPI interrupts

Hiroyuki Yokoyama (1):
      ARM: shmobile: r8a7794: Add SYS-DMAC clocks to device tree

Hisashi Nakamura (3):
      ARM: shmobile: koelsch: Fix QSPI mode of SPI-Flash into mode3
      ARM: shmobile: lager: Fix QSPI mode of SPI-Flash into mode3
      ARM: shmobile: r8a7794: Add QSPI clock to device tree

Kazuya Mizuguchi (1):
      ARM: shmobile: r8a7794: Add USBDMAC[01] clocks to device tree

Koji Matsuoka (1):
      ARM: shmobile: r8a7794: Add I2C clocks to device tree

Laurent Pinchart (1):
      ARM: shmobile: ape6evm: Fix LAN9220 VDDVARIO voltage

Magnus Damm (3):
      ARM: shmobile: r8a7779: Use R8A7779_CLK_P as SCIF parent clock
      ARM: shmobile: r8a7779: Use MSTP for SCIF clocks
      ARM: shmobile: r8a7779: Add TWD device to DTS

Ryo Kataoka (1):
      ARM: shmobile: r8a7791: Add IPMMU-SGX clock to device tree

Shinobu Uehara (3):
      ARM: shmobile: r8a7794: Add USB clocks to device tree
      ARM: shmobile: r8a7794: Add SDHI clocks to device tree
      ARM: shmobile: r8a7794: Add MMCIF clock to device tree

Simon Horman (1):
      ARM: shmobile: dts: koelsch: Fix flash partition label and size

Ulrich Hecht (5):
      ARM: shmobile: ape6evm: fix compatible string for Ethernet controller
      ARM: shmobile: ape6evm: synchronize dts with reference platform
      ARM: shmobile: ape6evm: Add LEDs to the device tree
      ARM: shmobile: ape6evm: Add keypad to the device tree
      ARM: shmobile: r8a73a4: Add r8a73a4-ape6evm.dtb to ARCH_SHMOBILE_MULTI

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           | 173 +++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7740.dtsi                  |  10 +-
 arch/arm/boot/dts/r8a7779.dtsi                  |  39 ++++--
 arch/arm/boot/dts/r8a7790-lager.dts             |   2 +
 arch/arm/boot/dts/r8a7790.dtsi                  |  33 +++--
 arch/arm/boot/dts/r8a7791-koelsch.dts           |  12 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  40 +++---
 arch/arm/boot/dts/r8a7794.dtsi                  |  82 ++++++++---
 include/dt-bindings/clock/r8a7790-clock.h       |   1 +
 include/dt-bindings/clock/r8a7791-clock.h       |   2 +
 include/dt-bindings/clock/r8a7794-clock.h       |  17 +++
 13 files changed, 333 insertions(+), 81 deletions(-)
