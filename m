From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 17:09:21 -0700
Subject: [PATCH 00/10] ARM: bcm: Add support for Broadcom Hurricane 2 SoC
Message-ID: <20170926000931.670-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds basic (boot to prompt with essential peripherals
working) support for Broadcom's Hurricane 2 SoC which is found in switching
applications.

This is also an iProc-family chip with a number of variations, including
some in the clock controller that I have not been able to identify yet.

Florian Fainelli (10):
  MAINTAINERS: Update Broadcom iProc regexp with Hurricane 2
  dt-bindings: Add documentation for Broadcom Hurricane 2 SoCs
  ARM: bcm: Add support for Broadcom Hurricane 2 SoC
  dt-bindings: Document Broadcom Hurricane 2 clocks
  clk: bcm: Add Broadcom Hurricane 2 clock support
  ARM: dts: Add Broadcom Hurricane 2 DTS include file
  ARM: debug: Add Hurricane 2 UART2 debug addresses
  dt-bindings: Add Ubiquiti Networks vendor prefix
  ARM: dts: Hurricane 2: Add basic support for Ubiquiti UniFi Switch 8
  ARM: multi_v7_defconfig: Enable CONFIG_ARCH_BCM_HR2

 .../devicetree/bindings/arm/bcm/brcm,hr2.txt       |  14 +
 .../bindings/clock/brcm,iproc-clocks.txt           |  14 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm/Kconfig.debug                             |  10 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/bcm-hr2.dtsi                     | 368 +++++++++++++++++++++
 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts  |  85 +++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/mach-bcm/Kconfig                          |   9 +
 arch/arm/mach-bcm/Makefile                         |   3 +
 arch/arm/mach-bcm/bcm_hr2.c                        |  25 ++
 drivers/clk/bcm/Kconfig                            |   9 +
 drivers/clk/bcm/Makefile                           |   1 +
 drivers/clk/bcm/clk-hr2.c                          |  27 ++
 15 files changed, 569 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
 create mode 100644 arch/arm/boot/dts/bcm-hr2.dtsi
 create mode 100644 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
 create mode 100644 arch/arm/mach-bcm/bcm_hr2.c
 create mode 100644 drivers/clk/bcm/clk-hr2.c

-- 
2.14.1
