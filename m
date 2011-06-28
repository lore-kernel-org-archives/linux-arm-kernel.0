From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 28 Jun 2011 14:49:12 +0200
Subject: [PATCH 0/5] remove spi-s3c24xx-gpio driver
Message-ID: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi-s3c24xx-gpio driver is functionally equivalent to the spi-gpio
driver (but precedes it). The driver has seen very little development 
since it got added back in 2006, and there's only 2 in-tree users of it.

This patch series moves the remaining users to the spi-gpio driver and
then finally removes the driver.

Compile tested only as I don't have access to the hardware.

 arch/arm/mach-s3c2410/include/mach/spi-gpio.h |   28 ----
 arch/arm/mach-s3c2410/mach-qt2410.c           |   34 +----
 arch/arm/mach-s3c2412/mach-jive.c             |   41 ++----
 arch/arm/mach-s3c2440/mach-gta02.c            |    1 -
 drivers/spi/Kconfig                           |   10 --
 drivers/spi/Makefile                          |    1 -
 drivers/spi/spi-s3c24xx-gpio.c                |  200 -------------------------
 7 files changed, 22 insertions(+), 293 deletions(-)

--
Bye, Peter Korsgaard
