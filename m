From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 15 Sep 2010 16:55:36 -0700
Subject: [PATCH 00/10] OMAP: misc PM queue for 2.6.37
Message-ID: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various OMAP PM related updates targetted for 2.6.37.

Also available in my pm-next branch:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-next

Kevin Hilman (4):
  OMAP3: PM: whitespace cleanup around IO wakeup enable
  OMAP3: PM: move device-specific special cases from PM core into
    CPUidle
  Revert "OMAP: omap_device: add omap_device_is_valid()"
  OMAP: omap_device: make all devices a child of a new parent device

Paul Walmsley (1):
  OMAP clockdomain: initialize clockdomain registers when the
    clockdomain layer starts

Santosh Shilimkar (3):
  omap: pm-debug: Move common debug code to pm-debug.c
  omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
  omap: pm: Move set_pwrdm_state routine to common pm.c

Thara Gopinath (2):
  OMAP: PM debugfs removing OMAP3 hardcodings.
  OMAP4: pm.c extensions for OMAP4 support

 arch/arm/mach-omap2/clockdomain.c             |  110 ++++---------------------
 arch/arm/mach-omap2/cpuidle34xx.c             |   50 +++++++++++-
 arch/arm/mach-omap2/pm-debug.c                |   42 ++++++++-
 arch/arm/mach-omap2/pm.c                      |   70 +++++++++++++++-
 arch/arm/mach-omap2/pm.h                      |    4 +-
 arch/arm/mach-omap2/pm34xx.c                  |   99 ++--------------------
 arch/arm/plat-omap/include/plat/common.h      |    3 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    4 +-
 arch/arm/plat-omap/omap_device.c              |   32 +++-----
 9 files changed, 191 insertions(+), 223 deletions(-)

-- 
1.7.2.1
