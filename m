From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:22:48 +0800
Subject: [PATCH 0/3] ARM: mxs: icoll code cleanup
Message-ID: <1364224971-28431-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series cleans up mxs icoll code and then moves it into
drivers/irqchip.  It's another step to multiplatform support.

Shawn Guo (3):
  ARM: mxs: get icoll base address from device tree
  ARM: mxs: call stmp_reset_block() in icoll
  ARM: mxs: move icoll driver into drivers/irqchip

 arch/arm/mach-mxs/Makefile                         |    2 +-
 arch/arm/mach-mxs/include/mach/common.h            |    3 ---
 arch/arm/mach-mxs/mach-mxs.c                       |    6 +++--
 drivers/irqchip/Makefile                           |    1 +
 .../mach-mxs/icoll.c => drivers/irqchip/irq-mxs.c  |   24 ++++++++------------
 include/linux/irqchip/mxs.h                        |   14 ++++++++++++
 6 files changed, 30 insertions(+), 20 deletions(-)
 rename arch/arm/mach-mxs/icoll.c => drivers/irqchip/irq-mxs.c (89%)
 create mode 100644 include/linux/irqchip/mxs.h

-- 
1.7.9.5
