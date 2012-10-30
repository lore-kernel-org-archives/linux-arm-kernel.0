From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Oct 2012 09:54:17 -0500
Subject: [PATCH 0/7] Move GIC and VIC to drivers/irqchip
Message-ID: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

I think I had this action from San Francisco Linaro Connect. Well, better 
late than never... Now we need to move GIC for use by arm64.

This series builds on Thomas Petazzoni's series adding a common irqchip
init function[1] and moves the ARM GIC and VIC irqchip code to
drivers/irqchip.

Tested on highbank and compiled on all defconfigs.

Rob

[1] http://www.spinics.net/lists/arm-kernel/msg203687.html

Rob Herring (3):
  irqchip: Move ARM GIC to drivers/irqchip
  irqchip: Move ARM VIC to drivers/irqchip
  ARM: highbank: use common irqchip_init

 arch/arm/common/Kconfig                            |   23 -------------------
 arch/arm/common/Makefile                           |    2 --
 arch/arm/mach-highbank/highbank.c                  |    8 ++-----
 drivers/irqchip/Kconfig                            |   23 +++++++++++++++++++
 drivers/irqchip/Makefile                           |    2 ++
 arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |    0
 arch/arm/common/vic.c => drivers/irqchip/irq-vic.c |    0
 drivers/irqchip/irqchip.c                          |   24 ++++++++++++++++++++
 drivers/irqchip/irqchip.h                          |    2 ++
 9 files changed, 53 insertions(+), 31 deletions(-)
 rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (100%)
 rename arch/arm/common/vic.c => drivers/irqchip/irq-vic.c (100%)

-- 
1.7.10.4
