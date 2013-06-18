From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 17 Jun 2013 23:56:13 -0400
Subject: [PATCH V3 0/5] input: pxa27x-keypad: enhancement and device tree
 support
Message-ID: <1371527778-5236-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches include 2 parts
1. use matrix_keypad for matrix keyes support
2. add device tree support for pxa27x-keypad

V2->V1:
Do not copy the members from pdata. For device tree support,
directly allocate the pdata structure.

V3->V2
add matrix_keypad changes for all boards using pxa27x-keypad
under mach-pxa.
The patch "arm: pxa: use matrix_keymap for all boards" is new.
The patch "arm: mmp: use matrix_keymap for all boards" merges
previous changes for aspenite and teton_bga.
All other patches are not modified.

Chao Xie (5):
  input: pxa27x-keypad: use matrix_keymap for matrix keyes
  arm: mmp: use matrix_keymap for all boards
  arm: pxa: use matrix_keymap for all boards
  input: pxa27x-keypad: remove the unused members at platform data
  input: pxa27x-keypad: add device tree support

 .../devicetree/bindings/input/pxa27x-keypad.txt    |   60 +++++
 arch/arm/mach-mmp/aspenite.c                       |   10 +-
 arch/arm/mach-mmp/teton_bga.c                      |   10 +-
 arch/arm/mach-pxa/em-x270.c                        |   20 +-
 arch/arm/mach-pxa/ezx.c                            |   60 +++--
 arch/arm/mach-pxa/littleton.c                      |   10 +-
 arch/arm/mach-pxa/mainstone.c                      |   10 +-
 arch/arm/mach-pxa/mioa701.c                        |   11 +-
 arch/arm/mach-pxa/palmld.c                         |   10 +-
 arch/arm/mach-pxa/palmt5.c                         |   10 +-
 arch/arm/mach-pxa/palmtreo.c                       |   23 ++-
 arch/arm/mach-pxa/palmtx.c                         |   10 +-
 arch/arm/mach-pxa/palmz72.c                        |   10 +-
 arch/arm/mach-pxa/tavorevb.c                       |   10 +-
 arch/arm/mach-pxa/z2.c                             |   10 +-
 arch/arm/mach-pxa/zylonite.c                       |   10 +-
 drivers/input/keyboard/Kconfig                     |    1 +
 drivers/input/keyboard/pxa27x_keypad.c             |  266 ++++++++++++++++++--
 include/linux/platform_data/keypad-pxa27x.h        |    3 +-
 19 files changed, 468 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/pxa27x-keypad.txt

-- 
1.7.4.1
