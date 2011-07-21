From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Thu, 21 Jul 2011 17:10:00 +0200
Subject: [PATCH v4 0/6] mc13783: add pwr button support
Message-ID: <1311261006-28048-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This add button handling for the MC13783 PMIC.
The first patch modify the mc13783 MFD driver to add a button
subdevice and also adds the mc13783-pwrbutton driver using a misc
input device.

The second patch adds the power on button support to the mx31moboard boards.

Patch 3 & 4 modify the mc13xxx MFD driver to use the platform data to 
register the led subdevice and unconditionally register the regulator
subdevice (as suggested by Mark and Uwe).

Patch 5 remove the use of the *_USE_REGULATOR and *_USE_LED in the platform
files.

Patch 6 must be applied after patch 3,4,5 to remove the obsolete define.

v2: first patch modified according to comments by Dmitry Torokhov
v3: Implement review by Uwe
v4: Implement comments by Uwe and Mark

Philippe R?tornaz (6):
  mc13783: add power button support
  mx31moboard: Add MC13783 power button support
  mc13xxx: Unconditionally register regulator subdevice
  mc13xxx: implicitly register led subdevice
  mc13xxx: remove obsolete leds and regualtors flags
  mc13xxx: remove unused define

 arch/arm/mach-imx/mach-mx27_3ds.c      |    1 -
 arch/arm/mach-imx/mach-mx31_3ds.c      |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c      |    3 +-
 arch/arm/mach-imx/mach-mx31moboard.c   |   11 +-
 arch/arm/mach-imx/mach-pcm038.c        |    3 +-
 arch/arm/mach-mx5/mx51_efika.c         |    2 +-
 drivers/input/misc/Kconfig             |   10 +
 drivers/input/misc/Makefile            |    1 +
 drivers/input/misc/mc13783-pwrbutton.c |  288 ++++++++++++++++++++++++++++++++
 drivers/mfd/mc13xxx-core.c             |   12 +-
 include/linux/mfd/mc13783.h            |    3 +-
 include/linux/mfd/mc13xxx.h            |   19 ++-
 12 files changed, 337 insertions(+), 18 deletions(-)
 create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
