From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Jun 2017 13:10:40 -0700
Subject: [GIT PULL 3/7] Broadcom devicetree-arm64 changes for 4.13 (v2)
In-Reply-To: <20170613201044.9808-1-f.fainelli@gmail.com>
References: <20170613201044.9808-1-f.fainelli@gmail.com>
Message-ID: <20170613201044.9808-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/devicetree-arm64

for you to fetch changes up to 39b1aae758de6f933f8b45698b56221f6e817dc9:

  Merge tag 'bcm2835-dt-64-next-2017-06-08' into devicetree-arm64/next (2017-06-13 12:39:57 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree changes for
4.13. Please note the following from Eric:

I've based this summary on the bcm2835-dt-next tag, to clarify what's in this
patch series, but it does require being careful since it involves a cross-merge
between branches.

- Anup documents the Broadcom Stingray binding, common clocks, adds initial
  support for the Stingray DTSI and DTS files and adds support for the PL022,
  PL330 and SP805

- Sandeep adds the clock nodes to the Stingray Device Tree nodes

- Pramod adds support for the NAND, pinctrl, GPIO to the Stingray Device Tree nodes

- Oza adds I2C Device Tree nodes to the Stingray DTSes

- Srinath adds PWM and SDHCI Device Tree nodes for the Stingray SoC

- Ravijeta adds support for the USB Dual Role PHY on Northstar 2

- Gerd starts adding references to the sdhost and sdhci controllers, and then
  switches the sdcard to to use the SDHOST (faster than SDHCI)

- Stefan defines the BCM2837 thermal coefficients in order for the Raspberry Pi
  thermal driver to work correctly

----------------------------------------------------------------
Anup Patel (3):
      dt-bindings: bcm: Add Broadcom Stingray bindings document
      arm64: dts: Initial DTS files for Broadcom Stingray SOC
      arm64: dts: Add PL022, PL330 and SP805 DT nodes for Stingray

Baruch Siach (4):
      ARM: dts: bcm2835: fix uart0 pinctrl node names
      ARM: dts: bcm2835: fix i2c0 pins
      ARM: dts: bcm2835: fix uart0/uart1 pins
      ARM: dts: bcm2835: add index to the ethernet alias

Eric Anholt (2):
      ARM: dts: Add devicetree for the Raspberry Pi 3, for arm32 (v6)
      Merge tag 'bcm2835-dt-next-2017-06-08' into bcm2835-dt-64-next

Florian Fainelli (2):
      Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/next
      Merge tag 'bcm2835-dt-64-next-2017-06-08' into devicetree-arm64/next

Gerd Hoffmann (2):
      arm64: dts: bcm2837: add &sdhci and &sdhost
      ARM: dts: bcm283x: switch from &sdhci to &sdhost

Oza Pawandeep (1):
      arm64: dts: Add I2C DT nodes for Stingray SoC

Pramod Kumar (3):
      arm64: dts: Add NAND DT nodes for Stingray SOC
      arm64: dts: Add pinctrl DT nodes for Stingray SOC
      arm64: dts: Add GPIO DT nodes for Stingray SOC

Raviteja Garimella (1):
      arm64: dts: NS2: Add USB DRD PHY device tree node

Sandeep Tripathy (2):
      dt-bindings: clk: Extend binding doc for Stingray SOC
      arm64: dts: Add clock DT nodes for Stingray SOC

Srinath Mannam (1):
      arm64: dts: Add PWM and SDHCI DT nodes for Stingray SOC

Stefan Wahren (2):
      ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
      ARM64: dts: bcm2837: Define CPU thermal coefficients

 .../devicetree/bindings/arm/bcm/brcm,stingray.txt  |  12 +
 .../bindings/clock/brcm,iproc-clocks.txt           |  76 ++++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   2 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |   4 +
 arch/arm/boot/dts/bcm2836.dtsi                     |   4 +
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |   1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi        |   2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi        |   2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |  43 +-
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |  17 +
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          |   4 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  14 +
 arch/arm64/boot/dts/broadcom/stingray/Makefile     |   6 +
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 131 ++++++
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |  78 ++++
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |  40 ++
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi | 170 ++++++++
 .../dts/broadcom/stingray/stingray-pinctrl.dtsi    | 345 ++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 460 +++++++++++++++++++++
 include/dt-bindings/clock/bcm-sr.h                 | 101 +++++
 .../dt-bindings/pinctrl/brcm,pinctrl-stingray.h    |  68 +++
 23 files changed, 1570 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
 create mode 100644 include/dt-bindings/clock/bcm-sr.h
 create mode 100644 include/dt-bindings/pinctrl/brcm,pinctrl-stingray.h
