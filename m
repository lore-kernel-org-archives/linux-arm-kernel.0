From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Jan 2012 15:55:33 +0100
Subject: [PATCH 0/7] at91 : pm.h cleanups
Message-ID: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is the first series to cleanup some code around pm.h, pm.c and
cpuidle. The next series will bring more cleanups and finally the third series
will change the different functions into ops where we can export the structure
definition in order to encapsulate the code and move the at91's cpuidle driver
to the drivers/cpuidle directory.

Tested on Calao Systems - USB-A9263
Compiled for AT91RM9200

Daniel Lezcano (7):
  at91 : coding style fixes
  at91 : declare header name
  at91 : group headers inclusion for the memory controller
  at91 : convert pm.h macros to static inline functions
  at91 : fix dirty hack for the selfrefresh function
  at91 : group selfrefresh functions
  at91 : fix compilation warning

 arch/arm/mach-at91/cpuidle.c              |    6 +-
 arch/arm/mach-at91/include/mach/at91_mc.h |   22 +++++
 arch/arm/mach-at91/pm.c                   |   46 ++++++----
 arch/arm/mach-at91/pm.h                   |  136 +++++++++++++++--------------
 4 files changed, 122 insertions(+), 88 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/at91_mc.h

-- 
1.7.4.1
