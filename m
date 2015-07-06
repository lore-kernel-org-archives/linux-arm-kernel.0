From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 15:39:17 +0530
Subject: [PATCH 0/2] clockevent/drivers: Migrate to new 'set-state' interface
Message-ID: <cover.1436177111.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas/Daniel,

These two drivers are recently migrated from arch/arm/ to
drivers/clocksource and so weren't part of earlier series.

Migrating to new set-state interface would enable these drivers to use
new states (like: ONESHOT_STOPPED, etc.) of a clockevent device (if
required), as the set-mode interface is marked obsolete now and wouldn't
be expanded to handle new states.

Rebased over: v4.2-rc1

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>

Viresh Kumar (2):
  clockevents/drivers/timer-imx-gpt: Migrate to new 'set-state'
    interface
  clockevents/drivers/timer-sp804: Migrate to new 'set-state' interface

 drivers/clocksource/timer-imx-gpt.c | 75 +++++++++++++++++++------------------
 drivers/clocksource/timer-sp804.c   | 54 +++++++++++++-------------
 2 files changed, 65 insertions(+), 64 deletions(-)

-- 
2.4.0
