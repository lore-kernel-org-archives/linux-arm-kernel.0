From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 30 Aug 2014 18:46:05 +0200
Subject: [Patch v3] 0/7] Remove mach-kirkwood
Message-ID: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is mostly a resend of these patches, removing mach-kirkwood.  Not
all maintainers picked up there patches, which has resulted in some
dead kernel configuration in v3.17-rcX.

The patch set has been rebased on v3.17-rc2, and it is intended that
Jason Cooper will submit them for inclusion in an RC. Subsystem
maintainers do not need to do anything.

The last patch "cpufreq: Remove ARCH_KIRKWOOD dependency" is new,
since what it is removing was added during v3.16-rcX. It follows the
pattern of all the other patches.

Andrew Lunn (7):
  cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
  ata: Remove ARCH_KIRKWOOD dependency
  thermal: Remove ARCH_KIRKWOOD dependency
  leds: Remove ARCH_KIRKWOOD dependency
  rtc: Remove ARCH_KIRKWOOD dependency
  watchdog: Remove ARCH_KIRKWOOD dependency
  cpufreq: Remove ARCH_KIRKWOOD dependency

 drivers/ata/Kconfig         | 2 +-
 drivers/cpufreq/Kconfig.arm | 2 +-
 drivers/cpuidle/Kconfig.arm | 2 +-
 drivers/leds/Kconfig        | 4 ++--
 drivers/rtc/Kconfig         | 2 +-
 drivers/thermal/Kconfig     | 2 +-
 drivers/watchdog/Kconfig    | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

--
2.1.0

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm at vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide at vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm at vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-leds at vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog at vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
