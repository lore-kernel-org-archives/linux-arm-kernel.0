From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 7 Mar 2012 15:57:41 +0530
Subject: [PATCH 00/15] watchdog/mpcore: updates & fixes
Message-ID: <cover.1331115751.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset contains fixes and updates for ARM mpcore watchdog driver.
Changes are mentioned in following patch list:

Viresh Kumar (15):
  watchdog/mpcore_wdt: Fix multiline comments
  watchdog/mpcore_wdt: Add blank line after variable definitions in
    routines
  watchdog/mpcore_wdt: Arrange #includes in alphabetical order
  watchdog/mpcore_wdt: remove multiple 'ret = 0' statements from ioctl
    ops
  watchdog/mpcore_wdt: Rename dev to pdev for pointing to struct
    platform_device
  watchdog/mpcore_wdt: do request_irq before registering misc device
  watchdog/mpcore_wdt: Use devm routines
  watchdog/mpcore_wdt: handle module param mpcore_margin in probe
  watchdog/mpcore_wdt: convert to use module_platform_driver()
  watchdog/mpcore_wdt: Add support for dev_pm_ops interface
  watchdog/mpcore_wdt: disable wdt in suspend only if it is busy
  watchdog/mpcore_wdt: Add support for WDIOF_CARDRESET
  watchdog/mpcore_wdt: Allow platform_get_irq() to fail
  watchdog/mpcore_wdt: Add clock framework support
  watchdog/mpcore_wdt: use correct clk_rate to program timeout

 arch/arm/include/asm/smp_twd.h |   12 ++
 drivers/watchdog/mpcore_wdt.c  |  409 ++++++++++++++++++++++++----------------
 2 files changed, 255 insertions(+), 166 deletions(-)

-- 
1.7.8.110.g4cb5d
