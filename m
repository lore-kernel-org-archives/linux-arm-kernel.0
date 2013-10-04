From: syin@broadcom.com (Sherman Yin)
Date: Thu, 3 Oct 2013 17:23:15 -0700
Subject: [PATCH 0/4] Add Broadcom Capri pinctrl driver
Message-ID: <1380846199-12829-1-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches adds a pinctrl driver for Broadcom Capri (BCM281xx) SoCs.
The first patch, adding the void * to pinctrl_pin_desc, has been previously
discussed with LinusW.  See this thread:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/165880.html

Sherman Yin (4):
  pinctrl: Add void * to pinctrl_pin_desc
  pinctrl: Add pinctrl binding for Broadcom Capri SoCs
  ARM: pinctrl: Add Broadcom Capri pinctrl driver
  pinctrl: Enable pinctrl for Broadcom Capri SoCs

 .../bindings/pinctrl/brcm,capri-pinctrl.txt        |  419 +++++
 arch/arm/boot/dts/bcm11351.dtsi                    |    4 +
 arch/arm/mach-bcm/Kconfig                          |    2 +
 drivers/pinctrl/Kconfig                            |   10 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-capri.c                    | 1727 ++++++++++++++++++++
 include/linux/pinctrl/pinctrl.h                    |    2 +
 7 files changed, 2165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,capri-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-capri.c

-- 
1.7.9.5
