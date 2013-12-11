From: syin@broadcom.com (Sherman Yin)
Date: Wed, 11 Dec 2013 10:37:15 -0800
Subject: [PATCH v3 0/6] Add Broadcom Capri pinctrl driver
In-Reply-To: <1381174108-25168-1-git-send-email-syin@broadcom.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
Message-ID: <1386787041-6035-1-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches adds a pinctrl driver for Broadcom Capri (BCM281xx) SoCs.
The first patch, adding the void * to pinctrl_pin_desc, has been previously
discussed with LinusW.  See this thread:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/165880.html
---
v3: Re-worked driver to be based on generic pinconfig, addressed review
    comments and other supporting changes:
    - moved config selection from Kconfig to defconfig
    - added slew-rate, input enable, input disable properties for generic
      pinconfig
    - added a description for PINCTRL config
v2: Use hyphens instead of underscore in DT property names.

Sherman Yin (6):
  pinctrl: Add void * to pinctrl_pin_desc
  pinctrl: Adds slew-rate, input-enable/disable
  pinctrl: Make PINCTRL selectable by defconfig/menuconfig
  pinctrl: Add pinctrl binding for Broadcom Capri SoCs
  ARM: pinctrl: Add Broadcom Capri pinctrl driver
  pinctrl: Enable pinctrl for Broadcom Capri SoCs

 .../bindings/pinctrl/brcm,capri-pinctrl.txt        |  429 ++++++
 .../bindings/pinctrl/pinctrl-bindings.txt          |    3 +
 arch/arm/boot/dts/bcm11351.dtsi                    |    4 +
 arch/arm/configs/bcm_defconfig                     |    5 +
 drivers/pinctrl/Kconfig                            |   13 +-
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinconf-generic.c                  |    4 +
 drivers/pinctrl/pinctrl-capri.c                    | 1408 ++++++++++++++++++++
 include/linux/pinctrl/pinconf-generic.h            |    4 +
 include/linux/pinctrl/pinctrl.h                    |    2 +
 10 files changed, 1872 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,capri-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-capri.c

-- 
1.7.9.5
