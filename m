From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 1 Oct 2015 12:55:45 +0200
Subject: [GIT PULL] STi DT changes for v4.4, round 1
Message-ID: <560D1131.8070708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v4.4:

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-dt-for-v4.4-1

for you to fetch changes up to cae010a1b663a779fdbfbf625839bc07dad16428:

   ARM: STi: STiH407: Enable the 2 HW Random Number Generators for 
STiH4{07, 10} (2015-10-01 11:02:09 +0200)

----------------------------------------------------------------
Highlights:
-----------
  - Add multiple pinctrl configurations to STiH407
  - Enable devices using pins only at board level
  - Add HW RNG device nodes to STiH407 family
  - Fix MMC0 clock configuration on STiH418
  - Fix interrupt related bindings on STiH407

----------------------------------------------------------------
Gabriel Fernandez (1):
       ARM: DT: STi: STiH418: Fix mmc0 clock configuration

Lee Jones (2):
       ARM: STi: DT: STiH407: Rename incorrect interrupt related binding
       ARM: STi: STiH407: Enable the 2 HW Random Number Generators for 
STiH4{07, 10}

Maxime Coquelin (3):
       ARM: dts: stih407: Enable PWM nodes only board level
       ARM: dts: stih407/410: Tidy up display nodes
       ARM: dts: stih410: Enable USB2.0 and related PHY nodes at board level

Peter Griffin (11):
       ARM: STi: DT: STiH407: Add a cec0 pin definition
       ARM: STi: DT: STiH407: Add i2c3 alternate pin configs
       ARM: DT: STiH407: Add SPI 3 wire and 4 wire pinctrl configs
       ARM: DT: STiH407: Add serial3 pinctrl configuration
       ARM: DT: STiH407: Add SPI FSM (NOR Flash) Controller pin config
       ARM: DT: STiH407: Add NAND flash controller pin configuration
       ARM: DT: STiH407: Add systrace pin configuration
       ARM: DT: STiH407: Add SD pinctrl config for mmc0 controller
       ARM: DT: STiH407: Add pinconfig for IRB UHF and IRB TX
       ARM: DT: STiH407: Add RMII pinctrl support
       ARM: STi: STiH407: Add spi default pinctrl groups.

  arch/arm/boot/dts/stih407-family.dtsi  |  47 +++-
  arch/arm/boot/dts/stih407-pinctrl.dtsi | 386 
++++++++++++++++++++++++++++++++-
  arch/arm/boot/dts/stih407.dtsi         |  13 --
  arch/arm/boot/dts/stih410-b2120.dts    |  24 ++
  arch/arm/boot/dts/stih410.dtsi         |  23 +-
  arch/arm/boot/dts/stih418.dtsi         |   6 +
  arch/arm/boot/dts/stihxxx-b2120.dtsi   |   8 +
  7 files changed, 471 insertions(+), 36 deletions(-)
