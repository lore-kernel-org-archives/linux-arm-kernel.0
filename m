From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:54:28 +0800
Subject: [PATCH 0/2] AT91 pm: add support to disable the DDR clock during the
 suspending
Message-ID: <1423709668-8539-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch series purpose is to disable the DDR controller's clock
and DDR system clock during the suspending to achive the lower power consumption.

Wenyou Yang (2):
  pm: at91: add the PM initialization for the sama5d3 and sama5d4
  pm: at91: add support to disable/enable the DDR clock

 arch/arm/mach-at91/generic.h              |    4 ++
 arch/arm/mach-at91/include/mach/sama5d3.h |    1 +
 arch/arm/mach-at91/include/mach/sama5d4.h |    5 ++
 arch/arm/mach-at91/pm.c                   |   25 +++++++++
 arch/arm/mach-at91/pm.h                   |    9 ++++
 arch/arm/mach-at91/pm_suspend.S           |   83 +++++++++++++++++++++++++++++
 arch/arm/mach-at91/sama5.c                |   10 +++-
 include/linux/clk/at91_pmc.h              |    1 +
 8 files changed, 136 insertions(+), 2 deletions(-)

-- 
1.7.9.5
