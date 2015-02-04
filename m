From: rjui@broadcom.com (Ray Jui)
Date: Tue, 3 Feb 2015 18:09:57 -0800
Subject: [PATCH v4 0/4] Add pinctrl support to Broadcom Cygnus SoC
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1423015801-26967-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial pinctrl (IOMUX) support for the Broadcom
Cygnus SoC. The Cygnus IOMUX controller supports group based mux configuration
and allows certain pins to be muxed to GPIO function individually

Changes from v3:
 - Fix the driver to have more proper use of "const" in various places
 - Other minor improvements

Changes from v2:
 - Consolidate all Broadcom pinctrl drivers into drivers/pinctrl/bcm/*
 - Change the Cygnus IOMUX driver to use standard Linux pinctrl subnode
properties such as "function" and "groups" for pinmux configuration, instead
of non-standard properties such as "brcm,function" and "brcm,group"
 - Use real function names like "spi0", "lcd", "key", and etc. instead of HW
specific mux names like "alt1", "alt2", "alt3", and etc.
 - Add suffix "grp" to all group names
 - Add support to allow individual pins to be muxed to GPIO function through
subsystem callbacks "gpio_request_enable" and "gpio_disable_free", and get rid
of all GPIO groups
 - Other minor improvements in the driver

Changes from v1:
 - Fix a typo in device tree binding document

Ray Jui (4):
  pinctrl: bcm: consolidate Broadcom pinctrl drivers
  pinctrl: Broadcom Cygnus pinctrl device tree binding
  pinctrl: cygnus: add initial IOMUX driver support
  ARM: dts: enable IOMUX for Broadcom Cygnus

 .../bindings/pinctrl/brcm,cygnus-pinmux.txt        |  157 +++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |    6 +
 drivers/pinctrl/Kconfig                            |   19 +-
 drivers/pinctrl/Makefile                           |    4 +-
 drivers/pinctrl/bcm/Kconfig                        |   34 +
 drivers/pinctrl/bcm/Makefile                       |    5 +
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c             | 1455 ++++++++++++++++++++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              | 1072 ++++++++++++++
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c           | 1088 +++++++++++++++
 drivers/pinctrl/pinctrl-bcm281xx.c                 | 1455 --------------------
 drivers/pinctrl/pinctrl-bcm2835.c                  | 1072 --------------
 11 files changed, 3820 insertions(+), 2547 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt
 create mode 100644 drivers/pinctrl/bcm/Kconfig
 create mode 100644 drivers/pinctrl/bcm/Makefile
 create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm281xx.c
 create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm2835.c
 create mode 100644 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
 delete mode 100644 drivers/pinctrl/pinctrl-bcm281xx.c
 delete mode 100644 drivers/pinctrl/pinctrl-bcm2835.c

-- 
1.7.9.5
