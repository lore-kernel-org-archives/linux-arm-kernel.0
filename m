From: thommycheck@gmx.de (Thomas Kunze)
Date: Mon,  5 Oct 2009 23:35:24 +0200
Subject: collie and SA1100 patches
Message-ID: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all!
   
This patchset implements prober power management for collie. To archieve this
some bugs were fixed and gpiolib-support was added to the ucb1x00 driver.
Please tell me if I should CC some other people or lists.

Regards,
Thomas

Statistics:
 arch/arm/mach-sa1100/collie.c              |   79 +++++-
 arch/arm/mach-sa1100/include/mach/collie.h |   77 +++---
 arch/arm/mach-sa1100/include/mach/gpio.h   |   19 +-
 arch/arm/mach-sa1100/include/mach/mcp.h    |    1 +
 drivers/leds/leds-locomo.c                 |    2 +-
 drivers/mfd/mcp-core.c                     |    2 +-
 drivers/mfd/mcp-sa11x0.c                   |    3 +-
 drivers/mfd/ucb1x00-assabet.c              |    2 +-
 drivers/mfd/ucb1x00-core.c                 |   89 ++++++-
 drivers/mfd/ucb1x00-ts.c                   |    2 +-
 drivers/power/Kconfig                      |    7 +
 drivers/power/Makefile                     |    1 +
 drivers/power/collie_battery.c             |  418 ++++++++++++++++++++++++++++
 {drivers => include/linux}/mfd/mcp.h       |    3 +
 {drivers => include/linux}/mfd/ucb1x00.h   |    7 +-
 15 files changed, 649 insertions(+), 63 deletions(-)
 create mode 100644 drivers/power/collie_battery.c
 rename {drivers => include/linux}/mfd/mcp.h (97%)
 rename {drivers => include/linux}/mfd/ucb1x00.h (98%)
