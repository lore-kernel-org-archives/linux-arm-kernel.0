From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 24 Jun 2013 14:39:51 +0200
Subject: [PATCH v3 0/3] regulator: max8998: Add support for Device Tree
Message-ID: <1372077594-17052-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds Device Tree support to max8998 MFD driver.

First patch reworks max8998-irq driver to use IRQ domains. Second patch
prepares platform data structure to ease generating it at runtime from
data parsed from device tree. Third patch implements Device Tree
binding and adds necessary documentation.

Tested on Universal C210 board.

Changes since v2:
 - switched to simple domains to retain compatibility with platforms
   that do not support Device Tree
 - removed clocks from DT regulator bindings (will be moved to common
   clock framework in further patch)
 - beautified the code a bit
Changes since v1:
 - rebased to current for-next of regulator tree

Tomasz Figa (3):
  mfd: Add irq domain support for max8998 interrupts
  regulator: max8998: Use arrays for specifying voltages in platform
    data
  mfd: max8998: Add support for Device Tree

 Documentation/devicetree/bindings/mfd/max8998.txt | 108 ++++++++++
 arch/arm/mach-exynos/mach-universal_c210.c        |   8 +-
 arch/arm/mach-s5pv210/mach-aquila.c               |   8 +-
 arch/arm/mach-s5pv210/mach-goni.c                 |   8 +-
 drivers/mfd/Kconfig                               |   1 +
 drivers/mfd/max8998-irq.c                         |  65 +++---
 drivers/mfd/max8998.c                             |  75 ++++++-
 drivers/regulator/max8998.c                       | 239 +++++++++++++++-------
 drivers/rtc/rtc-max8998.c                         |  14 +-
 include/linux/mfd/max8998-private.h               |   7 +-
 include/linux/mfd/max8998.h                       |  20 +-
 11 files changed, 421 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max8998.txt

-- 
1.8.2.1
