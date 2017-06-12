From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Jun 2017 10:31:07 -0700
Subject: [GIT PULL 3/5] Broadcom devicetree-arm64 changes for 4.13
In-Reply-To: <20170612173109.11188-1-f.fainelli@gmail.com>
References: <20170612173109.11188-1-f.fainelli@gmail.com>
Message-ID: <20170612173109.11188-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/devicetree-arm64

for you to fetch changes up to 779ec2a607909bd87332c458813ac6d21d74f7cb:

  arm64: dts: NS2: Add USB DRD PHY device tree node (2017-06-08 13:57:34 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree changes for
4.13, please pull the following:

- Anup documents the Broadcom Stingray binding, common clocks, adds initial
  support for the Stingray DTSI and DTS files and adds support for the PL022,
  PL330 and SP805

- Sandeep adds the clock nodes to the Stingray Device Tree nodes

- Pramod adds support for the NAND, pinctrl, GPIO to the Stingray Device Tree nodes

- Oza adds I2C Device Tree nodes to the Stingray DTSes

- Srinath adds PWM and SDHCI Device Tree nodes for the Stingray SoC

- Ravijeta adds support for the USB Dual Role PHY on Northstar 2

----------------------------------------------------------------
Anup Patel (3):
      dt-bindings: bcm: Add Broadcom Stingray bindings document
      arm64: dts: Initial DTS files for Broadcom Stingray SOC
      arm64: dts: Add PL022, PL330 and SP805 DT nodes for Stingray

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

 .../devicetree/bindings/arm/bcm/brcm,stingray.txt  |  12 +
 .../bindings/clock/brcm,iproc-clocks.txt           |  76 ++++
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
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
 13 files changed, 1502 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
 create mode 100644 include/dt-bindings/clock/bcm-sr.h
 create mode 100644 include/dt-bindings/pinctrl/brcm,pinctrl-stingray.h
