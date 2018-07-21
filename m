From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Jul 2018 23:05:16 -0700
Subject: [GIT PULL] am654 changes for v4.19 merge window
Message-ID: <pull-1532152828-552759@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/am654-for-v4.19-signed

for you to fetch changes up to d0a064bec75e20a526c7bc0d626912f2660b6e81:

  arm64: dts: ti: Add support for AM654 EVM base board (2018-07-18 11:48:36 -0700)

----------------------------------------------------------------
TI AM654 support for v4.19 merge window

This branch adds initial support for new Texas Instruments AM654
quad core A53 ARMv8 SoC. It's the first device for TI K3 multicore SoC
architecture.

Initially only basic devices are configured, support for more devices
will follow later on. And many of the internal devices familiar from
earlier TI SoCs should work with existing kernel device drivers.

----------------------------------------------------------------
Nishanth Menon (5):
      dt-bindings: arm: ti: Add bindings for AM654 SoC
      arm64: Add support for TI's K3 Multicore SoC architecture
      arm64: dts: ti: Add Support for AM654 SoC
      soc: ti: Add Support for AM654 SoC config option
      arm64: dts: ti: Add support for AM654 EVM base board

 Documentation/devicetree/bindings/arm/ti/k3.txt |  23 +++++
 MAINTAINERS                                     |   9 ++
 arch/arm64/Kconfig.platforms                    |   7 ++
 arch/arm64/boot/dts/Makefile                    |   1 +
 arch/arm64/boot/dts/ti/Makefile                 |   9 ++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |  31 +++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi             |  87 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |  36 ++++++++
 arch/arm64/boot/dts/ti/k3-am654.dtsi            | 115 ++++++++++++++++++++++++
 drivers/soc/ti/Kconfig                          |  14 +++
 10 files changed, 332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
 create mode 100644 arch/arm64/boot/dts/ti/Makefile
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi
