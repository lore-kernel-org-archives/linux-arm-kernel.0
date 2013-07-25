From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Fri, 26 Jul 2013 00:42:12 +0200
Subject: [PATCH v3 0/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
Message-ID: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds initial support for Broadcom network SoC from the BCM5301X 
and BCM470X line.

The debug patch should be changed or later applied to conform with the 
new style.

If the vendor prefix should be changes to something else, I will change 
it to whatever name.

The vendor BSP also uses BCM5301X for this SoC, so I just toke that.

A bootlog can be found here:
http://pastebin.com/2FeBGCY5

Changes since v2:
 * use vendor prefix brcm
 * move code to arch/arm/mach-bcm/
 * cleanup arch/arm/mach-bcm/bcm5301x.c
 * rename to bcm5301x
 * split into more patches

Changes since v1:
 * add file Documentation/devicetree/bindings/arm/bcm4708.txt
 * rename bcm5301x to bcm4708 in dts files
 * use preprocessor includes in dts file
 * add CONFIG_ARCH_BCM53XX to multi_v7_defconfig
 * remove init_machine callback
 * rename vendor prefix from brcm to bcm
 * split into two patches


Hauke Mehrtens (3):
  ARM: BCM5301X: initial support for the BCM5301X/BCM470X SoCs with ARM
    CPU
  ARM: BCM5301X: add early debugging support
  ARM: BCM5301X: add dts files for BCM4708 SoC

 Documentation/devicetree/bindings/arm/bcm4708.txt |    8 +++
 MAINTAINERS                                       |    8 +++
 arch/arm/Kconfig.debug                            |    5 ++
 arch/arm/Makefile                                 |    2 +-
 arch/arm/boot/dts/Makefile                        |    1 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts       |   20 ++++++
 arch/arm/boot/dts/bcm4708.dtsi                    |   74 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig               |    1 +
 arch/arm/include/debug/bcm5301x.S                 |   19 ++++++
 arch/arm/mach-bcm/Kconfig                         |   21 ++++++
 arch/arm/mach-bcm/Makefile                        |    1 +
 arch/arm/mach-bcm/bcm5301x.c                      |   59 ++++++++++++++++
 12 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm4708.txt
 create mode 100644 arch/arm/boot/dts/bcm4708-netgear-r6250.dts
 create mode 100644 arch/arm/boot/dts/bcm4708.dtsi
 create mode 100644 arch/arm/include/debug/bcm5301x.S
 create mode 100644 arch/arm/mach-bcm/bcm5301x.c

-- 
1.7.10.4
