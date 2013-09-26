From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Sep 2013 18:06:05 +0200
Subject: [RFC PATCH 0/2] ARM: at91: cpuidle: encapsulate and move the driver
 to drivers/cpuidle
Message-ID: <1380211567-2972-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several patches were send to encapsulate the standby code.

Creating a platform driver model allows to finish to encapsulate this code more
and make possible to move the driver to the drivers/cpuidle directory.

I was not able to test the patchset, I don't have the hardware.

Daniel Lezcano (2):
  ARM: at91: cpuidle: convert to platform driver
  ARM: at91: cpuidle: Move driver to drivers/cpuidle

 arch/arm/mach-at91/Makefile    |    1 -
 arch/arm/mach-at91/cpuidle.c   |   68 ---------------------------------------
 arch/arm/mach-at91/pm.c        |   16 +++++++++-
 drivers/cpuidle/Kconfig.arm    |    6 ++++
 drivers/cpuidle/Makefile       |    1 +
 drivers/cpuidle/cpuidle-at91.c |   69 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/mach-at91/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-at91.c

-- 
1.7.9.5
