From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 26 May 2017 14:54:53 +0530
Subject: [PATCH v5 00/11] Broadcom Stingray SOC Initial Support
Message-ID: <1495790704-2438-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds initial support of Broadcom Stingray SOC
by reusing existing Broadcom iProc device drivers.

Most of the patches in this patchset are DT patches except
the Stingray clock tree support which just one patch.

This patchset is based on Linux-4.12-rc2 and it is also available
at stingray-v5 branch of https://github.com/Broadcom/arm64-linux.git

Changes since v4:
 - Reduce number of include headers in Stingray clk driver

Changes since v3:
 - Rebased patches for Linux-4.12-rc1
 - Updated PATCH3 to have all clocks except genpll3 to be
   registered via platform driver probe

Changes since v2:
 - Remove default bootargs from chosen DT node
 - Remove "linux" prefix from stdout DT attribute of chosen DT node
 - Remove use of GIC_CPU_MASK_xxx() for PPIs

Changes since v1:
 - Rebased patches for Linux-4.12-rc1
 - Removed unwanted /memreserve/ from bcm958742-base.dtsi
 - Use ranges DT property to clear view of memory-layout
 - Make bcm-sr.h part of clock DT bindings patch

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

Sandeep Tripathy (3):
  dt-bindings: clk: Extend binding doc for Stingray SOC
  clk: bcm: Add clocks for Stingray SOC
  arm64: dts: Add clock DT nodes for Stingray SOC

Srinath Mannam (1):
  arm64: dts: Add PWM and SDHCI DT nodes for Stingray SOC

 .../devicetree/bindings/arm/bcm/brcm,stingray.txt  |  12 +
 .../bindings/clock/brcm,iproc-clocks.txt           |  76 ++++
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
 arch/arm64/boot/dts/broadcom/stingray/Makefile     |   6 +
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 131 ++++++
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |  78 ++++
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |  40 ++
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi | 170 ++++++++
 .../dts/broadcom/stingray/stingray-pinctrl.dtsi    | 345 ++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 460 +++++++++++++++++++++
 drivers/clk/bcm/Kconfig                            |   8 +
 drivers/clk/bcm/Makefile                           |   1 +
 drivers/clk/bcm/clk-sr.c                           | 320 ++++++++++++++
 include/dt-bindings/clock/bcm-sr.h                 | 101 +++++
 .../dt-bindings/pinctrl/brcm,pinctrl-stingray.h    |  68 +++
 15 files changed, 1817 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
 create mode 100644 drivers/clk/bcm/clk-sr.c
 create mode 100644 include/dt-bindings/clock/bcm-sr.h
 create mode 100644 include/dt-bindings/pinctrl/brcm,pinctrl-stingray.h

-- 
2.7.4
