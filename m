From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Fri, 16 Sep 2016 12:39:24 +0200
Subject: [PATCH v2 0/3] ARM: aspeed: add support for the BT IPMI interface
Message-ID: <1474022367-21029-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This serie adds support for the iBT interface on Aspeed SOCs (AST2400
and AST2500). The BT (Block Transfer) interface is used to perform
in-band IPMI communication between a host and its BMC. This driver
implements the BMC side.

Most noticeable changes in v2 are:

 - the driver is now called 'bt-bmc' and the device node '/dev/ipmi-bt-host'
   
 - the code is now under drivers/char/ipmi/. This required a change of
   the top Makefile in drivers/ to compile the bt-bmc driver with the
   ipmi handlers not being selected. That might be an issue.
   
 - changed the read/write operations to use a temporary buffer and get
   rid of the {get,put}_user calls

Thanks,

C.

Alistair Popple (1):
  misc: Add Aspeed BT IPMI BMC driver

C?dric Le Goater (2):
  ARM: aspeed: Add defconfigs for CONFIG_ASPEED_BT_IPMI_BMC
  ARM: dts: aspeed: Enable BT IPMI BMC device

 .../bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt   |  23 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   6 +
 arch/arm/configs/aspeed_g4_defconfig               |   1 +
 arch/arm/configs/aspeed_g5_defconfig               |   1 +
 drivers/Makefile                                   |   2 +-
 drivers/char/ipmi/Kconfig                          |   7 +
 drivers/char/ipmi/Makefile                         |   1 +
 drivers/char/ipmi/bt-bmc.c                         | 486 +++++++++++++++++++++
 include/uapi/linux/Kbuild                          |   1 +
 include/uapi/linux/bt-bmc.h                        |  18 +
 11 files changed, 551 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
 create mode 100644 drivers/char/ipmi/bt-bmc.c
 create mode 100644 include/uapi/linux/bt-bmc.h

-- 
2.7.4
