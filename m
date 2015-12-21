From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 21 Dec 2015 19:27:29 +0800
Subject: [PATCH 0/6] misc: add reboot mode driver
Message-ID: <1450697249-29994-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This driver parse the reboot commands like "reboot loader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the vendor specific write interfae
to store the boot mode in some place like special register
or sram , which can be read by the bootloader after system
reboot.

This is commonly done on Android based devices, in order to
reboot the device into fastboot or recovery mode.

Before this patch , I have try some hack on[0], and then found
John Stultz also doing the same work[1].

As John is busy these days, I go on with this work.

[0]https://patchwork.kernel.org/patch/7647751/
[1]https://patchwork.kernel.org/patch/7802391/


Andy Yan (6):
  dt-bindings: misc: add document for reboot-mode driver
  dt-bindings: soc: add document for rockchip reboot-mode driver
  misc: add reboot mode driver
  soc: rockchip: add reboot mode driver
  ARM: dts: rockchip: add reboot mode node
  ARM64: dts: rockchip: add reboot mode node

 .../devicetree/bindings/misc/reboot-mode.txt       | 41 +++++++++
 .../bindings/soc/rockchip/rockchip,reboot-mode.txt | 39 +++++++++
 arch/arm/boot/dts/rk3288.dtsi                      | 25 ++++++
 arch/arm/boot/dts/rk3xxx.dtsi                      | 26 ++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           | 26 ++++++
 drivers/misc/Kconfig                               |  7 ++
 drivers/misc/Makefile                              |  1 +
 drivers/misc/reboot_mode.c                         | 96 ++++++++++++++++++++++
 drivers/power/reset/Kconfig                        |  1 -
 drivers/soc/rockchip/Kconfig                       |  8 ++
 drivers/soc/rockchip/Makefile                      |  1 +
 drivers/soc/rockchip/loader.h                      | 22 +++++
 drivers/soc/rockchip/reboot.c                      | 66 +++++++++++++++
 include/dt-bindings/soc/rockchip_boot-mode.h       | 30 +++++++
 include/linux/reboot.h                             |  4 +-
 15 files changed, 391 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,reboot-mode.txt
 create mode 100644 drivers/misc/reboot_mode.c
 create mode 100644 drivers/soc/rockchip/loader.h
 create mode 100644 drivers/soc/rockchip/reboot.c
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

-- 
1.9.1
