From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 20 Jul 2018 10:18:59 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.19
Message-ID: <20180720081859.GA22228@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are the unusually large DT PR for AT91. It contains mainly new DTs.

There is a pm.c change that I'm including here so it is along with the
corresponding DT changes.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.19-dt

for you to fetch changes up to c8cbc1c20c29697e7335a5044fe6c60aa5c6e922:

  ARM: dts: at91: fix typos for SSC TD functions (2018-07-20 10:05:14 +0200)

----------------------------------------------------------------
AT91 DT for 4.19:

 - New boards from Laird: WB45N, WB50N, SOM60 modules and DVK, Gatwick
 - fix the PMC compatibles

----------------------------------------------------------------
Alexandre Belloni (4):
      dt-bindings: arm: remove PMC bindings
      dt-bindings: clk: at91: Document all the PMC compatibles
      ARM: at91: fix USB clock detection handling
      ARM: dts: fix PMC compatible

Ben Whitten (6):
      dt-bindings: add laird and giantec vendor prefix
      ARM: dts: at91: add labels to soc dtsi for derivative boards
      ARM: dts: add support for Laird WB45N cpu module and DVK
      ARM: dts: add support for Laird WB50N cpu module and DVK
      ARM: dts: add support for Gatwick board based on WB50N
      ARM: dts: add support for Laird SOM60 module and DVK boards

Claudiu Beznea (1):
      ARM: dts: at91: fix typos for SSC TD functions

 .../devicetree/bindings/arm/atmel-pmc.txt          |  14 --
 .../devicetree/bindings/clock/at91-clock.txt       |   9 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/at91-dvk_som60.dts               |  95 +++++++++
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi          | 159 ++++++++++++++
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi      |  90 ++++++++
 arch/arm/boot/dts/at91-gatwick.dts                 | 121 +++++++++++
 arch/arm/boot/dts/at91-som60.dtsi                  | 230 +++++++++++++++++++++
 arch/arm/boot/dts/at91-wb45n.dts                   |  64 ++++++
 arch/arm/boot/dts/at91-wb45n.dtsi                  | 165 +++++++++++++++
 arch/arm/boot/dts/at91-wb50n.dts                   | 112 ++++++++++
 arch/arm/boot/dts/at91-wb50n.dtsi                  | 198 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9261.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   8 +-
 arch/arm/boot/dts/sama5d2-pinfunc.h                |   4 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   8 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
 arch/arm/mach-at91/pm.c                            |   5 +
 21 files changed, 1263 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt
 create mode 100644 arch/arm/boot/dts/at91-dvk_som60.dts
 create mode 100644 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
 create mode 100644 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
 create mode 100644 arch/arm/boot/dts/at91-gatwick.dts
 create mode 100644 arch/arm/boot/dts/at91-som60.dtsi
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dtsi

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
