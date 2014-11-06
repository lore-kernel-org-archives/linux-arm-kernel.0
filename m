From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 06 Nov 2014 16:11:56 +0100
Subject: [PATCH RESEND v3 0/4] power/mfd: Add max77693 charger driver
Message-ID: <1415286720-6358-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,


I got ack from Sebastian [1] but only for charger driver patch. This
means that I still need an ack for documentation (bindings, sysfs)...


Changes since v2
================
1. Add ack from Sebastian Reichel (charger driver).
2. Drop patch "mfd: max77693: Map charger device to its own of_node"
   (applied by Lee Jones).


Changes since v1
================
1. Add patch 2/5: mfd: max77693: Map charger device to its own of_node
   (forgot to send it in v1)
2. Remove patches for DTS and configs. I'll send them later.
3. Add ack from Lee Jones (patch 3/5).


Description
===========
The patchset adds max77693 charger driver present on Trats2 board
(and Galaxy S III). The driver configures battery charger and exposes
power supply interface.

Driver is necessary to provide full charging stack on Trats2 device
(extcon, charger-manager etc.).

[1] https://lkml.org/lkml/2014/10/27/774


Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  devicetree: power/mfd: max77693: Document new bindings for charger
  mfd: max77693: Add defines for MAX77693 charger driver
  power: max77693: Add charger driver for Maxim 77693
  Documentation: power: max77693-charger: Document exported sysfs entry

 Documentation/ABI/testing/sysfs-class-power        |  42 ++
 Documentation/devicetree/bindings/mfd/max77693.txt |  45 ++
 drivers/power/Kconfig                              |   6 +
 drivers/power/Makefile                             |   1 +
 drivers/power/max77693_charger.c                   | 763 +++++++++++++++++++++
 include/linux/mfd/max77693-private.h               | 108 +++
 include/linux/mfd/max77693.h                       |   8 +
 7 files changed, 973 insertions(+)
 create mode 100644 drivers/power/max77693_charger.c

-- 
1.9.1
