From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Mon, 17 May 2010 18:40:21 +0200
Subject: [PATCH 0/2] mc13783: LED support
Message-ID: <1274114423-30020-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This adds led support for the MC13783 PMIC. 
The first patch modify the mc13783 MFD driver to add a led subdevice
and also adds the leds-mc13783 driver.

The second patch adds the RGB leds support on the mx31moboard boards.

I have only tested the RGB led part since I don't have the hardware 
to test with the others leds. 

Regards,
Philippe

Philippe R?tornaz (2):
  mc13783: add LED support
  mx31moboard: Add MC13783 led support

 arch/arm/mach-mx3/mach-mx31moboard.c |   45 ++++-
 drivers/leds/Kconfig                 |    7 +
 drivers/leds/Makefile                |    1 +
 drivers/leds/leds-mc13783.c          |  375 ++++++++++++++++++++++++++++++++++
 drivers/mfd/mc13783-core.c           |    4 +
 include/linux/mfd/mc13783.h          |   68 ++++++
 6 files changed, 499 insertions(+), 1 deletions(-)
 create mode 100644 drivers/leds/leds-mc13783.c
