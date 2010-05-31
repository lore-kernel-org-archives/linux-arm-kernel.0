From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Mon, 31 May 2010 21:28:58 +0200
Subject: [PATCH 0/2] mc13783: add pwr button support
Message-ID: <1275334140-29339-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This add button handling for the MC13783 PMIC.
The first patch modify the mc13783 MFD driver to add a button 
subdevice and also adds the mc13783-pwrbutton driver using a misc
input device.

The second patch adds the power on button support to the mx31moboard
boards.

Regards,
Philippe


Philippe R?tornaz (2):
  mc13783: add power button support
  mx31moboard: Add MC13783 power button support

 arch/arm/mach-mx3/mach-mx31moboard.c   |   10 +-
 drivers/input/misc/Kconfig             |    7 +
 drivers/input/misc/Makefile            |    1 +
 drivers/input/misc/mc13783-pwrbutton.c |  301 ++++++++++++++++++++++++++++++++
 drivers/mfd/mc13783-core.c             |    4 +
 include/linux/mfd/mc13783.h            |   19 ++
 6 files changed, 341 insertions(+), 1 deletions(-)
 create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
