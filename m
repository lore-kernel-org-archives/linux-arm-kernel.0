From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 9 Apr 2013 17:57:57 +0530
Subject: [PATCH 0/4] ARM: davinci: fix UART clock enabling
Message-ID: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch series addresses below issues:
1) Do clk_get on dev_id when there is single clock for a module
2) Fix garbled UART log with DT kernel on da850-evm.

Applies on top of v3.9-rc9 of Linus's.
Tested on da850-evm. Able to see proper bootup log and console on UART2.

Manjunathappa, Prakash (4):
  ARM: davinci: uart: move to devid based clk_get
  ARM: davinci: da850: override device name of UART in DT kernel
  ARM: davinci: da850: do not specify clock_frequency for UART DT node
  ARM: davinci: da8xx: remove da8xx_uart_clk_enable

 arch/arm/boot/dts/da850.dtsi                   |    3 -
 arch/arm/mach-davinci/da830.c                  |    8 ++--
 arch/arm/mach-davinci/da850.c                  |    8 ++--
 arch/arm/mach-davinci/da8xx-dt.c               |   11 +----
 arch/arm/mach-davinci/devices-da8xx.c          |   40 ++++++++++++++++---
 arch/arm/mach-davinci/devices-tnetv107x.c      |   35 ++++++++++++++---
 arch/arm/mach-davinci/dm355.c                  |   48 ++++++++++++++++++-----
 arch/arm/mach-davinci/dm365.c                  |   35 ++++++++++++----
 arch/arm/mach-davinci/dm644x.c                 |   48 ++++++++++++++++++-----
 arch/arm/mach-davinci/dm646x.c                 |   49 +++++++++++++++++++-----
 arch/arm/mach-davinci/include/mach/da8xx.h     |    2 +-
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +-
 arch/arm/mach-davinci/serial.c                 |   19 ++++++---
 arch/arm/mach-davinci/tnetv107x.c              |    8 ++--
 14 files changed, 233 insertions(+), 83 deletions(-)

-- 
1.7.4.1
