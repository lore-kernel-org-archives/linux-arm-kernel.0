From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 19 May 2013 23:39:33 +0200
Subject: [RFC PATCH 0/5] ARM: mv78x00: First step to convert mv78x00 to Device
 Tree
Message-ID: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set is a first step in order to convert mach-mv78x00 to
device tree before it joins mach-mvebu.

I managed to test it on the RD-78X00-mASA board. All the peripherals I
have tested work as they work before the migration to the device tree:
- UART
- Ethernet
- USB
- SATA

My main concern is that the mv78x00 are MP but not SMP
capable. Currently the same kernel run on the 2 cores and it is in the
board file that the peripherals are assigned for each CPU. (Actually I
didn't test this behavior, but the code is written in this way.)

I don't know how to assign a peripheral to a given CPU with the device
tree. The only way I have in mind is to have a dts per CPU, but I am
not sure it is very convenient.

So for now the code assigns all the peripherals to the CPU.

I am also concerned by the 2 other boards: the Marvell DB-78x00-BP
Development Board and the Buffalo WLX (Terastation Duo) NAS. I don't
have them and so I can't test them if I want to convert them to device
tree too.

Comments and ideas are welcome

Thanks,

Gregory CLEMENT (5):
  ARM: mv78x00: Add generic support for the Device Tree boards
  ARM: mv78x00: Convert RD-78X00-mASA board to device tree
  ARM: mv78x00: Add infrastructure to support boards converted to DT
  ARM: mv78x00: Add the Device Tree support for MV78X00 family
  ARM: mv78x00: Add Device Tree support for the RD-78X00-mASA board

 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/mv78x00-masa-db.dts      |  61 ++++++++++++++
 arch/arm/boot/dts/mv78x00.dtsi             | 126 +++++++++++++++++++++++++++++
 arch/arm/mach-mv78xx0/Kconfig              |   7 ++
 arch/arm/mach-mv78xx0/Makefile             |   1 +
 arch/arm/mach-mv78xx0/board-dt.c           |  49 +++++++++++
 arch/arm/mach-mv78xx0/common.h             |   7 ++
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c |  10 +++
 8 files changed, 262 insertions(+)
 create mode 100644 arch/arm/boot/dts/mv78x00-masa-db.dts
 create mode 100644 arch/arm/boot/dts/mv78x00.dtsi
 create mode 100644 arch/arm/mach-mv78xx0/board-dt.c

-- 
1.8.1.2
