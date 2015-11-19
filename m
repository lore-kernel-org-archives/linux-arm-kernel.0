From: pramodku@broadcom.com (Pramod Kumar)
Date: Thu, 19 Nov 2015 09:22:12 +0530
Subject: [PATCH v2 0/7] Generalized broadcom cygnus gpio driver
Message-ID: <1447905139-16002-1-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generalized pinctrl-cygnus-gpio driver so that it could be used for all
iProc architecture based future SoCs having same gpio pin controller.
Generalization process made the below changes in driver-

1. Addressed number of pins from DT through "ngpios" property and removed
from driver.
2. Since all iProc based SoCs would use this driver hence renamed all
variables/macros/functions and even file name on iproc.


This patchset applies on v4.4-rc1 and is tested on cygnus SVK and could be
find at-
https://github.com/Broadcom/arm64-linux/tree/iproc-gpio-v2

Changes from v1:
-Rebased patches to v4.4-rc1
-Removed accepted patches

Pramod Kumar (7):
  dt-binding: Add ngpios property to GPIO controller node
  dts: define ngpios property in gpio controller's node
  pinctrl: use ngpios propety from DT
  pinctrl: Add new compatible string to GPIO controller driver
  gpio: Rename func/macro/var to IP-block,iproc
  Documentation: Rename gpio controller name from cygnus to iproc
  pinctrl: Rename gpio driver from cygnus to iproc

 .../{brcm,cygnus-gpio.txt => brcm,iproc-gpio.txt}  |   9 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   3 +
 drivers/pinctrl/bcm/Kconfig                        |  30 +-
 drivers/pinctrl/bcm/Makefile                       |   2 +-
 ...{pinctrl-cygnus-gpio.c => pinctrl-iproc-gpio.c} | 355 ++++++++++-----------
 5 files changed, 198 insertions(+), 201 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{brcm,cygnus-gpio.txt => brcm,iproc-gpio.txt} (94%)
 rename drivers/pinctrl/bcm/{pinctrl-cygnus-gpio.c => pinctrl-iproc-gpio.c} (56%)

-- 
1.9.1
