From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jun 2015 15:50:17 +0200
Subject: [PATCH 0/5] EP93xx GENERIC_CLOCKEVENTS
Message-ID: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the EP93xx to GENERIC_CLOCKEVENTS.

After this only the RISC PC and EBSA110 uses GETTIMEOFFSET.

Linus Walleij (5):
  ARM: ep93xx: move timer to its own file
  ARM: ep93xx: switch to GENERIC_CLOCKEVENTS
  ARM: ep93xx: use non-raw accessors for timer
  ARM: ep93xx: switch clockevent to timer 3
  ARM: ep93xx: activate NO_HZ and high-res timers

 arch/arm/Kconfig                    |   3 +-
 arch/arm/configs/ep93xx_defconfig   |   2 +
 arch/arm/mach-ep93xx/Makefile       |   2 +-
 arch/arm/mach-ep93xx/core.c         | 109 ----------------------------
 arch/arm/mach-ep93xx/timer-ep93xx.c | 141 ++++++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 111 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/timer-ep93xx.c

-- 
1.9.3
