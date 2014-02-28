From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Fri, 28 Feb 2014 13:17:16 +0100
Subject: [PATCH 0/5] Add STiH407 SoC and reference board support
Message-ID: <1393589841-6634-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic support to the STMicroelectronics STiH407 SoC and its
B2120 reference board. The STiH407 is a dual-core ARM Cortex-A9 CPU aimed at
STB market.

Giuseppe Cavallaro (2):
  ARM: STi: add pinctrl support for the STiH407 SoC
  pinctrl: st: Enhance the controller to manage unavailable registers

Maxime Coquelin (3):
  ARM: STi: Add STiH407 SoC support
  ARM: dts: Add STiH407 SoC support
  ARM: dts: STiH407: Add B2120 board support

 Documentation/arm/sti/stih407-overview.txt    |  18 +
 Documentation/devicetree/bindings/arm/sti.txt |  15 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/stih407-b2120.dts           |  78 ++++
 arch/arm/boot/dts/stih407-clock.dtsi          |  41 ++
 arch/arm/boot/dts/stih407-pinctrl.dtsi        | 618 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stih407.dtsi                | 250 +++++++++++
 arch/arm/mach-sti/Kconfig                     |   9 +
 arch/arm/mach-sti/board-dt.c                  |   1 +
 drivers/pinctrl/pinctrl-st.c                  | 123 +++--
 10 files changed, 1110 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/arm/sti/stih407-overview.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sti.txt
 create mode 100644 arch/arm/boot/dts/stih407-b2120.dts
 create mode 100644 arch/arm/boot/dts/stih407-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih407-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih407.dtsi

-- 
1.9.0
