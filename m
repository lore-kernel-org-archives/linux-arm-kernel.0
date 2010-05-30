From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Sun, 30 May 2010 12:09:06 +0900
Subject: [PATCH v2 0/5] Add samsung keypad
Message-ID: <4C01D6D2.6030908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is patch v2 series to add Samsung keypad.

Changes since v1:
- Include linux/gpio.h instead of mach/gpio.h
- Switch to dev_pm_ops in the samsung keypad driver

---
Joonyoung Shim (5):
      ARM: SAMSUNG: Add keypad device support
      ARM: S5PV210: Add keypad device helpers
      ARM: S5PV210: Add keypad device to the GONI board
      ARM: S5PV210: Add keypad device to the Aquila board
      input: samsung-keypad - Add samsung keypad driver

 arch/arm/mach-s5pv210/Kconfig                    |    9 +
 arch/arm/mach-s5pv210/Makefile                   |    1 +
 arch/arm/mach-s5pv210/include/mach/map.h         |    3 +
 arch/arm/mach-s5pv210/mach-aquila.c              |   25 ++
 arch/arm/mach-s5pv210/mach-goni.c                |   26 ++
 arch/arm/mach-s5pv210/setup-keypad.c             |   34 ++
 arch/arm/plat-samsung/Kconfig                    |    7 +-
 arch/arm/plat-samsung/Makefile                   |    1 +
 arch/arm/plat-samsung/dev-keypad.c               |   50 +++
 arch/arm/plat-samsung/include/plat/devs.h        |    2 +
 arch/arm/plat-samsung/include/plat/keypad.h      |   57 ++++
 arch/arm/plat-samsung/include/plat/regs-keypad.h |   49 +++
 drivers/input/keyboard/Kconfig                   |    9 +
 drivers/input/keyboard/Makefile                  |    1 +
 drivers/input/keyboard/samsung-keypad.c          |  364 ++++++++++++++++++++++
 15 files changed, 637 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-keypad.c
 create mode 100644 arch/arm/plat-samsung/dev-keypad.c
 create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-keypad.h
 create mode 100644 drivers/input/keyboard/samsung-keypad.c
