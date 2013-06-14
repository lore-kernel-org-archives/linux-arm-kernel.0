From: avinashphilipk@gmail.com (Philip Avinash)
Date: Fri, 14 Jun 2013 15:27:47 +0530
Subject: [PATCH 0/2] Fix build breakage for tnetv107x platforms
Message-ID: <1371203869-16308-1-git-send-email-avinashphilipk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tnetv107x_defconfig build failing on removal selection of NEED_MACH_GPIO_H
for ARCH_DAVINCI. This is due to header files inclusion from mach/gpio-davinci.h
So this patch series fixes the build breakage on removal of NEED_MACH_GPIO_H.

This patch series is based on Linux 3.10-rc4 and is availabel at [1] and dependency on 2.

1. https://github.com/avinashphilip/am335x_linux/tree/linux_davinci_v3.10_soc_gpio_v310-rc4
2. https://patchwork.kernel.org/patch/97853/

Philip Avinash (2):
  ARM: davinci: fix for build breakage for tnetv107x platforms
  gpio: gpio-tnetv107x: Fix bulid breakge

 arch/arm/mach-davinci/board-tnetv107x-evm.c |    5 +++--
 drivers/gpio/gpio-tnetv107x.c               |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.7.9.5
