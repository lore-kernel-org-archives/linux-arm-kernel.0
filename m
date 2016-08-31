From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed, 31 Aug 2016 19:24:16 +0200
Subject: [PATCH 0/3] ARM: aspeed: add support for the BT IPMI host device 
Message-ID: <1472664259-23933-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This serie adds support for the BT IPMI host device on Aspeed SoCs
ast2400 and ast2500. 

Cheers,

C.

Alistair Popple (1):
  misc: Add Aspeed BT IPMI host driver

C?dric Le Goater (2):
  ARM: aspeed: Add defconfigs for CONFIG_ASPEED_BT_IPMI_HOST
  ARM: dts: aspeed: Enable BT IPMI host device

 .../devicetree/bindings/misc/aspeed,bt-host.txt    |  19 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   6 +
 arch/arm/configs/aspeed_g4_defconfig               |   1 +
 arch/arm/configs/aspeed_g5_defconfig               |   1 +
 drivers/misc/Kconfig                               |   5 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/bt-host.c                             | 433 +++++++++++++++++++++
 include/uapi/linux/Kbuild                          |   1 +
 include/uapi/linux/bt-host.h                       |  18 +
 10 files changed, 491 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed,bt-host.txt
 create mode 100644 drivers/misc/bt-host.c
 create mode 100644 include/uapi/linux/bt-host.h

-- 
2.7.4
