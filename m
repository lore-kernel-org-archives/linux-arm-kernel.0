From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 2 Mar 2012 13:55:21 +0100
Subject: [PATCH 0/2] Remove bq24022 driver superseeded by gpio-regulator
Message-ID: <201203021355.21669.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bq24022 regulator is simply a more specialised variant of the now
present gpio-regulator. Therefore it probably shouldn't stay around.

This series converts the two users of bq24022 pxa/hx4700 and
pxa/magician to use the gpio-regulator instead, and after this removes
the then unused bq24022 driver.

The series was compile-tested only, but the gpio-regulator itself is
sucessfully used on my platform for the dcdc3 of a tps650240 (voltage
regulator with one gpio) and for a bq24075 (current regulator with two
gpios). So I'm quite sure it should work correctly but would welcome
testers :-) .

Heiko Stuebner (2):
  pxa: magician/hx4700: Convert to gpio-regulator from bq24022
  regulator: Remove bq24022 regulator driver

 arch/arm/configs/magician_defconfig |    2 +-
 arch/arm/mach-pxa/hx4700.c          |   33 ++++++--
 arch/arm/mach-pxa/magician.c        |   33 ++++++--
 drivers/regulator/Kconfig           |    8 --
 drivers/regulator/Makefile          |    1 -
 drivers/regulator/bq24022.c         |  162 -----------------------------------
 include/linux/regulator/bq24022.h   |   24 -----
 7 files changed, 55 insertions(+), 208 deletions(-)
 delete mode 100644 drivers/regulator/bq24022.c
 delete mode 100644 include/linux/regulator/bq24022.h

-- 
1.7.5.4
