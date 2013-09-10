From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Sep 2013 14:29:42 +0200
Subject: [PATCH 0/7] IXP4 GPIO consolidation
Message-ID: <1378816182-7903-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an attempt to remove the custom GPIO API
with gpio_line* signatures from the IXP4 platform.
I'm looking for testing and ACKs to take this through
the GPIO tree eventually as part of the major clean-up
attempt.

Please do not report checkpatch errors on patch 7/7 as it
is just moving already existing code, not introducing new
code.

Linus Walleij (7):
  ARM: ixp4xx: convert remaining users to use gpiolib
  misc: ixp4-beeper: switch to use gpiolib
  misc: ixp4-beeper: use gpiolib strictly
  ptp: switch to use gpiolib
  staging: media/lirc: switch to use gpiolib
  ARM: ixp4: delete irq_to_gpio
  ARM: ixp4xx: stop broadcasting the custom GPIO API

 arch/arm/mach-ixp4xx/common.c                | 49 +++++++++++++++++++++-------
 arch/arm/mach-ixp4xx/dsmg600-setup.c         | 16 +++++----
 arch/arm/mach-ixp4xx/include/mach/platform.h | 39 ----------------------
 arch/arm/mach-ixp4xx/ixdp425-setup.c         |  8 +++--
 arch/arm/mach-ixp4xx/nas100d-setup.c         | 15 +++++----
 arch/arm/mach-ixp4xx/nslu2-setup.c           | 10 +++---
 drivers/input/misc/ixp4xx-beeper.c           | 25 +++++++++-----
 drivers/ptp/ptp_ixp46x.c                     |  9 ++++-
 drivers/staging/media/lirc/lirc_serial.c     | 16 +++++++--
 9 files changed, 102 insertions(+), 85 deletions(-)

-- 
1.8.3.1
