From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:22 +0530
Subject: [PATCH 00/14] ARM: SPEAr: DT updates
Message-ID: <cover.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

These are DT updates for SPEAr SoCs. There aren't any fixes that we want to get
into 3.7-rc* and we are happy with 3.8.

Please apply them from mail, as i wouldn't be hosting them in my repo.

Some of the dtbs which use gpiopinctrl have dependency on Linus's pinctrl tree,
where an earlier update for adding gpiopinctrl node is present.

Deepak Sikri (1):
  ARM: SPEAr: DT: Modify DT bindings for STMMAC

Shiraz Hashim (7):
  pinctrl: SPEAr: add spi chipselect control driver
  ARM: SPEAr13xx: DT: Add spics gpio controller nodes
  ARM: SPEAr: DT: Update device nodes
  ARM: SPEAr13xx: Remove fields not required for ssp controller
  ARM: SPEAr3xx: shirq: simplify and move the shared irq multiplexor to
    DT
  ARM: SPEAr3xx: DT: add shirq node for interrupt multiplexor
  ARM: SPEAr320: DT: Add SPEAr 320 HMI board support

Vipin Kumar (1):
  ARM: SPEAr: DT: Update partition info for MTD devices

Vipul Kumar Samar (5):
  ARM: SPEAr: DT: Update pinctrl list
  ARM: SPEAr: DT: Fix existing DT support
  ARM: SPEAr: DT: add uart state to fix warning
  ARM: SPEAr1310: Move 1310 specific misc register into machine
    specific files
  ARM: SPEAr1310: Fix AUXDATA for compact flash controller

 .../devicetree/bindings/arm/spear/shirq.txt        |  48 ++++
 .../bindings/pinctrl/pinctrl_spear_spics.txt       |  50 ++++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/spear1310-evb.dts                | 171 ++++++++++--
 arch/arm/boot/dts/spear1310.dtsi                   |  32 ++-
 arch/arm/boot/dts/spear1340-evb.dts                | 262 ++++++++++++++++--
 arch/arm/boot/dts/spear1340.dtsi                   |  61 +++++
 arch/arm/boot/dts/spear13xx.dtsi                   |  72 ++++-
 arch/arm/boot/dts/spear300-evb.dts                 |  20 +-
 arch/arm/boot/dts/spear300.dtsi                    |  14 +-
 arch/arm/boot/dts/spear310-evb.dts                 |  30 +-
 arch/arm/boot/dts/spear310.dtsi                    |  18 ++
 arch/arm/boot/dts/spear320-evb.dts                 |  35 ++-
 arch/arm/boot/dts/spear320-hmi.dts                 | 305 +++++++++++++++++++++
 arch/arm/boot/dts/spear320.dtsi                    |  39 ++-
 arch/arm/boot/dts/spear3xx.dtsi                    |   5 +-
 arch/arm/boot/dts/spear600-evb.dts                 |  46 +++-
 arch/arm/boot/dts/spear600.dtsi                    |  16 ++
 arch/arm/mach-spear13xx/include/mach/spear.h       |   8 -
 arch/arm/mach-spear13xx/spear1310.c                |  16 +-
 arch/arm/mach-spear13xx/spear13xx.c                |   2 -
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  10 +-
 arch/arm/mach-spear3xx/spear300.c                  | 103 -------
 arch/arm/mach-spear3xx/spear310.c                  | 202 --------------
 arch/arm/mach-spear3xx/spear320.c                  | 205 +-------------
 arch/arm/mach-spear3xx/spear3xx.c                  |   4 +
 arch/arm/plat-spear/include/plat/shirq.h           |  35 +--
 arch/arm/plat-spear/shirq.c                        | 305 +++++++++++++++++----
 drivers/clk/spear/spear1310_clock.c                |   1 +
 drivers/pinctrl/spear/Makefile                     |   4 +-
 drivers/pinctrl/spear/pinctrl-spics.c              | 217 +++++++++++++++
 31 files changed, 1638 insertions(+), 701 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spear/shirq.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl_spear_spics.txt
 create mode 100644 arch/arm/boot/dts/spear320-hmi.dts
 create mode 100644 drivers/pinctrl/spear/pinctrl-spics.c

-- 
1.7.12.rc2.18.g61b472e
