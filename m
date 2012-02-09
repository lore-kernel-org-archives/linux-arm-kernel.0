From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  9 Feb 2012 20:00:50 +0100
Subject: [PATCH 0/3] pinctrl: move the core per-device handlers to core
Message-ID: <1328814050-22715-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After discussing with some people involved with pin control, we agreed
that it will just cause trouble to have separate handles for pin muxing
and pin configuration in callers - they will definately want to set all
pin aspects regarding muxing and other configuration with one single
call.

These three patches take the first step in this transformation by moving
the per-device handles over to core code, and renaming all related
functions with the pinctrl_* prefix.

Linus Walleij (3):
  pinctrl: break out a pinctrl consumer header
  pinctrl: move generic functions to the pinctrl_ namespace
  pinctrl: factor pin control handles over to the core

 Documentation/pinctrl.txt        |  124 ++++---
 arch/arm/mach-u300/core.c        |   24 +-
 drivers/pinctrl/core.c           |  602 +++++++++++++++++++++++++++++++-
 drivers/pinctrl/core.h           |   34 ++-
 drivers/pinctrl/pinctrl-coh901.c |    6 +-
 drivers/pinctrl/pinmux.c         |  732 ++++++--------------------------------
 drivers/pinctrl/pinmux.h         |   67 ++++-
 include/linux/pinctrl/consumer.h |  118 ++++++
 include/linux/pinctrl/machine.h  |    8 +-
 include/linux/pinctrl/pinconf.h  |   39 --
 include/linux/pinctrl/pinmux.h   |   52 ---
 11 files changed, 991 insertions(+), 815 deletions(-)
 create mode 100644 include/linux/pinctrl/consumer.h

-- 
1.7.7.6
