From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  4 Feb 2013 18:21:06 +0100
Subject: [PATCH v4 0/2] Adding support for the new Armada XP development board
 from Marvell
Message-ID: <1359998469-28133-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the forth version (the third was not the last one finally) of
a patch set to add the dts support for new Armada XP development
board from Marvell called DB-MV784MP-GP.

The branch GP-board is available at
https://github.com/MISL-EBU-System-SW/mainline-public.git

Changelog:
v3->v4:
- change the amount of memory in DTS to indicate the size actually
  present on the board
- add a patch which allow the kernel to receive the amount of memory
  available on the board using ATAG (for legacy bootloader such as the
  one currently used on Marvell boards).

V2->v3
- fixed typos in comments
- fixed the compatible string for the board and use marvell,axp-gp
  instead of marvell,axp-db which was already used by an other board
- fixed the model name by remove the colon

v2->v1:
- added tested-by from Simon Guinot and Florian Fainelli
- added some comments to emphasize that the amount of memory may
  change.
- named the board ``development board''

Gregory CLEMENT (2):
  arm: mvebu: update defconfig with ATAG support when using DT
  arm: mvebu: support for the new Armada XP development
    board(DB-MV784MP-GP)

 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/boot/dts/armada-xp-gp.dts |  101 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/mvebu_defconfig   |    1 +
 3 files changed, 103 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts

-- 
1.7.9.5
