From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun,  5 Jan 2014 18:58:13 +0100
Subject: [PATCH v4 0/4] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
Message-ID: <1388944697-19927-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am working on mainlining this SoC again which I started in Summer 
2013.

This adds initial support for Broadcom network SoC from the BCM5301X 
and BCM470X line.

The vendor BSP also uses BCM5301X for this SoC, so I just toke that.

I haven't found a better solution than the abort handler for the memory fault.

I do not have any documentation, only the vendor source code published 
by Asus and Netgear to conform with the GPL, it would be nice to get 
some documentation for this Soc like this
https://www.broadcom.com/collateral/pg/440X-PG02-R.pdf
for the Broadcom BCM440X Ethernet controller.

With some additional patches I got Ethernet working with ~250 MBit/s.

A bootlog can be found here:
http://hauke-m.de/files/openwrt/devices/R6250/openwrt-boot-2014-01-05.txt

Changes since v3:
 * rebase on Linus 3.13-rc7
 * split the workaround into an own patch
 * add L2 cache controller to Device tree
 * rename config option
 * add local-timer and SCU entry to device tree

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

Hauke Mehrtens (4):
  ARM: BCM5301X: initial support for the BCM5301X/BCM470X SoCs with ARM
    CPU
  ARM: BCM5301X: add early debugging support
  ARM: BCM5301X: add dts files for BCM4708 SoC
  ARM: BCM5301X: workaround suppress fault

 Documentation/devicetree/bindings/arm/bcm4708.txt |    8 ++
 MAINTAINERS                                       |    7 ++
 arch/arm/Kconfig.debug                            |    7 ++
 arch/arm/boot/dts/Makefile                        |    1 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts       |   20 ++++
 arch/arm/boot/dts/bcm4708.dtsi                    |  102 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig               |    1 +
 arch/arm/mach-bcm/Kconfig                         |   27 ++++++
 arch/arm/mach-bcm/Makefile                        |    1 +
 arch/arm/mach-bcm/bcm_5301x.c                     |   60 ++++++++++++
 10 files changed, 234 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm4708.txt
 create mode 100644 arch/arm/boot/dts/bcm4708-netgear-r6250.dts
 create mode 100644 arch/arm/boot/dts/bcm4708.dtsi
 create mode 100644 arch/arm/mach-bcm/bcm_5301x.c

-- 
1.7.10.4
