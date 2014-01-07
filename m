From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue,  7 Jan 2014 23:58:08 +0100
Subject: [PATCH v7 0/4] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
Message-ID: <1389135492-11655-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds initial support for Broadcom network SoC from the BCM5301X 
and BCM470X line.

I do not have any documentation, only the vendor source code published 
by Asus and Netgear to conform with the GPL, it would be nice to get 
some documentation for this Soc like this
https://www.broadcom.com/collateral/pg/440X-PG02-R.pdf
for the Broadcom BCM440X Ethernet controller.

With some additional patches I got Ethernet working with ~250 MBit/s.

A bootlog can be found here:
http://hauke-m.de/files/openwrt/devices/R6250/openwrt-boot-2014-01-05.txt

This is based on arm-soc.git branch next/soc.

Christian Daudt or Olof Johansson could one of you take these patches please.


Changes since v6:
 * rebase on arm-soc.git branch next/soc
 * use ranges in dts files for SoC blocks

Changes since v5:
 * restructured the dts files, own file for the SoC family, the SoC and
   the device

Changes since v4:
 * removed bcm5301x_timer_init(), this function is not needed
 * removed GENERIC_TIME this is dead
 * made fault handler check for code and just catch the first fault.

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
 MAINTAINERS                                       |    8 ++
 arch/arm/Kconfig.debug                            |    7 ++
 arch/arm/boot/dts/Makefile                        |    1 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts       |   35 ++++++++
 arch/arm/boot/dts/bcm4708.dtsi                    |   34 ++++++++
 arch/arm/boot/dts/bcm5301x.dtsi                   |   95 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig               |    1 +
 arch/arm/mach-bcm/Kconfig                         |   26 ++++++
 arch/arm/mach-bcm/Makefile                        |    1 +
 arch/arm/mach-bcm/bcm_5301x.c                     |   61 +++++++++++++
 11 files changed, 277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm4708.txt
 create mode 100644 arch/arm/boot/dts/bcm4708-netgear-r6250.dts
 create mode 100644 arch/arm/boot/dts/bcm4708.dtsi
 create mode 100644 arch/arm/boot/dts/bcm5301x.dtsi
 create mode 100644 arch/arm/mach-bcm/bcm_5301x.c

-- 
1.7.10.4
