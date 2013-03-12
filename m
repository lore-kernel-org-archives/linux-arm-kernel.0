From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 01:41:30 +0100
Subject: [PATCH 0/7] ARM: S3C24XX: Convert S3C2416 to common clock framework
Message-ID: <201303120141.31262.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the upcoming change in pwm/samsung-time handling, this series is meant
as mere discussion source. Nevertheless applied to the current linux-samsung
for-next it sucessfully enables the s3c2416 to use the common clock framework.

This series is dependant on the previous samsung-clock fixes and obviously
tested on a s3c2416.

Heiko Stuebner (7):
  clk: samsung: add plls used in s3c2416 and s3c2443
  ARM: S3C24XX: add soc_is_s3c2416 and soc_is_s3c2443
  ARM: S3C24XX: enable legacy clock code only when SAMSUNG_CLOCK selected
  clk: samsung: add clock-driver for s3c2416, s3c2443 and s3c2450
  DO_NOT_APPLY: add clock driver for Samsung pwm clocks
  ARM: SAMSUNG: use clk_prepare_enable in samsung-time
  DO_NOT_APPLY: convert s3c2416 to use the common clock framework

 arch/arm/mach-s3c24xx/Kconfig            |    2 +-
 arch/arm/mach-s3c24xx/Makefile           |    2 +-
 arch/arm/mach-s3c24xx/clock-s3c2416.c    |  173 ----------
 arch/arm/mach-s3c24xx/common-s3c2443.c   |   12 +
 arch/arm/mach-s3c24xx/common.c           |    2 +
 arch/arm/mach-s3c24xx/common.h           |    9 +
 arch/arm/mach-s3c24xx/mach-smdk2416.c    |    9 +-
 arch/arm/plat-samsung/include/plat/cpu.h |   20 +
 arch/arm/plat-samsung/samsung-time.c     |    6 +-
 drivers/clk/samsung/Makefile             |    1 +
 drivers/clk/samsung/clk-pll.c            |  376 ++++++++++++++++++++
 drivers/clk/samsung/clk-pll.h            |    8 +
 drivers/clk/samsung/clk-pwm.c            |  554 ++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-s3c2443.c        |  463 +++++++++++++++++++++++++
 14 files changed, 1457 insertions(+), 180 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
 create mode 100644 drivers/clk/samsung/clk-pwm.c
 create mode 100644 drivers/clk/samsung/clk-s3c2443.c

-- 
1.7.2.3
