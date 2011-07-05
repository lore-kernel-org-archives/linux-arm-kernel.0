From: vkuzmichev@mvista.com (Vitaly Kuzmichev)
Date: Tue,  5 Jul 2011 23:00:34 +0400
Subject: [PATCH V2 0/6] arm_smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
Message-ID: <1309892440-3260-1-git-send-email-vkuzmichev@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches fixes various bugs in ARM MPCORE watchdog setup.
They also introduce some changes in common ARM_SMP_TWD timer setup code.
The PATCH 2/6 adds an exported function to obtain twd timer rate in
mpcore_wdt. However, this solution might be unacceptable, and the
better is to copy calibration loop and clk_get_rate calling to mpcore_wdt.

The series of patches is based on arm-platforms.git/local_timers_as_devices
branch since it looks like that it is going to be merged into the mainline.

V1 series was not discussed widely because I forgot to add all necessary
maintainers in Cc.

Vitaly Kuzmichev (6):
  arm_smp_twd: Fix typo in 'twd_timer_rate' printing
  arm_smp_twd: mpcore_wdt: Fix watchdog counter loading
  mpcore_wdt: Fix WDIOC_SETOPTIONS handling
  mpcore_wdt: Fix timer mode setup
  mpcore_wdt: Add cpufreq notifier to reload counter
  mpcore_wdt: Move declarations in a separate header

 drivers/clocksource/arm_smp_twd.c |   15 +++++++-
 drivers/watchdog/mpcore_wdt.c     |   71 +++++++++++++++++++++++-------------
 drivers/watchdog/mpcore_wdt.h     |   40 +++++++++++++++++++++
 3 files changed, 99 insertions(+), 27 deletions(-)
 create mode 100644 drivers/watchdog/mpcore_wdt.h

-- 
1.7.3.4
