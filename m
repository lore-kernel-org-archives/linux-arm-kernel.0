From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 5 May 2014 22:51:25 -0500
Subject: [GIT PULL] SOCFPGA DTS updates for 3.16, v3
Message-ID: <1399348285-6757-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v3.16. This is version 3 of the
original SOCFPGA DTS pull request for v3.16. This new tag omits the following
patches:

ARM: dts: socfpga: add gpio pieces -> Pending further discussion.
dt: bindings: Typo s/clocks-names/clock-names/g -> Already in Grant Likely's tree.

Also removes the artifact from a rebase that occurred in v2. So sorry about that.
I have also compile tested this tag.

Thanks,

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-updates-for-3.16_v3

for you to fetch changes up to 8cb289ed60668d3350dda5aa19b4fa1dce1c07f1:

  ARM: socfpga: dts: Add div-reg to the main_pll clocks (2014-05-05 22:33:18 -0500)

----------------------------------------------------------------
dts: socfpga: general updates for the socfpga platform

Mostly DTS additions to the SOCFPGA platform from Steffan Trumtrar, and a
couple of device tree documentation updates/typo fix.

This one does not the GPIO binding patch, as that is pending further
discussion. Also, v3 fixes a rebase artifact and compile tested.

----------------------------------------------------------------
Dinh Nguyen (4):
      ARM: socfpga: dts: add eeprom and rtc on i2c0
      ARM: socfpga: dts: Remove hard coded clock-frequency property
      ARM: socfpga: dts: Add DTS entries for USB
      ARM: socfpga: dts: Add div-reg to the main_pll clocks

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
 .../{arm/altera => reset}/socfpga-reset.txt        |    2 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/socfpga.dtsi                     |  118 +++++++++++++++++++-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   26 +----
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |   21 +++-
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   26 +----
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |   21 +++-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |    6 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |   50 +++++++++
 arch/arm/boot/dts/socfpga_vt.dts                   |    2 +-
 include/dt-bindings/reset/altr,rst-mgr.h           |   90 +++++++++++++++
 12 files changed, 305 insertions(+), 62 deletions(-)
 rename Documentation/devicetree/bindings/{arm/altera => reset}/socfpga-reset.txt (85%)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr.h
