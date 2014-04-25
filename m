From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 25 Apr 2014 17:57:49 -0500
Subject: [GIT PULL] SOCFPGA DTS updates for 3.16
Message-ID: <1398466670-8341-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v3.16. These consist mostly of
DTS updates and a few DTS bindings documentation updates for SOCFPGA.

Thanks,

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-updates-for-3.16

for you to fetch changes up to 2adecac3f50865b53c060949be4251a486547c48:

  dt: bindings: Typo s/clocks-names/clock-names/g (2014-04-24 17:52:30 -0500)

----------------------------------------------------------------
dts: socfpga: general updates for the socfpga platform

Mostly DTS additions to the SOCFPGA platform from Steffan Trumtrar, and a
couple of device tree documentation updates/typo fix.

----------------------------------------------------------------
Dinh Nguyen (4):
      ARM: socfpga: dts: add eeprom and rtc on i2c0
      ARM: socfpga: dts: Remove hard coded clock-frequency property
      ARM: socfpga: dts: Add DTS entries for USB
      ARM: socfpga: dts: Add div-reg to the main_pll clocks

Geert Uytterhoeven (1):
      dt: bindings: Typo s/clocks-names/clock-names/g

Sebastian Andrzej Siewior (1):
      ARM: dts: socfpga: add gpio pieces

Steffen Trumtrar (10):
      ARM: socfpga: dts: fix pdma interrupt
      ARM: socfpga: dts: add remaining interrupts for pdma
      ARM: socfpga: dts: add i2c busses
      ARM: socfpga: dts: add can0+1
      ARM: socfpga: dts: add support for EBV SOCrates
      ARM: socfpga: dts: add rtc on i2c0 to socrates
      ARM: socfpga: dts: convert to preprocessor includes
      Documentation: dt: socfpga: add reset-cells property
      Documentation: dt: reset: move socfpga-reset
      ARM: socfpga: dts: add reset-controller

 .../devicetree/bindings/clock/altr_socfpga.txt     |    4 +-
 .../devicetree/bindings/net/socfpga-dwmac.txt      |    2 +-
 Documentation/devicetree/bindings/net/stmmac.txt   |    2 +-
 .../{arm/altera => reset}/socfpga-reset.txt        |    2 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/socfpga.dtsi                     |  180 +++++++++++++++++++-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   26 +--
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |   21 ++-
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   26 +--
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |   21 ++-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |    6 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |   50 ++++++
 arch/arm/boot/dts/socfpga_vt.dts                   |    2 +-
 include/dt-bindings/reset/altr,rst-mgr.h           |   90 ++++++++++
 14 files changed, 369 insertions(+), 64 deletions(-)
 rename Documentation/devicetree/bindings/{arm/altera => reset}/socfpga-reset.txt (85%)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr.h
