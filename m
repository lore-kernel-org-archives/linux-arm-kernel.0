From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Jun 2013 20:50:24 +0530
Subject: [PATCH V3 00/14] watchdog: ARM mpcore Improvements
Message-ID: <cover.1371535241.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

** This still doesn't make it workable **

Hi,

ARM mpcore watchdog isn't workable and so is marked broken in the first patch of
the series. Reasons are mentioned in 01/14 and important links are shared too.

Other are basically improvements which I have written more than a year back. I
am just pushing them through as they still improve the driver (or broken
driver). They still don't fix the issues pointed out by Marc Zyngier earlier.
But as these are generic improvements I don't see why they can't be applied,
even to a still broken driver.

I don't want somebody to waste time reinventing these patches, rather they can
work on fixing the issues due to which this driver is broken.

I don't have hardware & time to fix the BROKEN part of this driver now :(

Link to the last version, nothing much changed after that. Just a resend:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/089076.html

Viresh Kumar (14):
  watchdog/mpcore_wdt: Mark it as BROKEN
  watchdog/mpcore_wdt: convert to watchdog core
  watchdog/mpcore_wdt: Fix multiline comments
  watchdog/mpcore_wdt: Arrange #includes in alphabetical order
  watchdog/mpcore_wdt: Set default heartbeat in probe instead of init
  watchdog/mpcore_wdt: convert to use module_platform_driver()
  watchdog/mpcore_wdt: Add support for dev_pm_ops interface
  watchdog/mpcore_wdt: disable wdt in suspend only if it is busy
  watchdog/mpcore_wdt: replace (__raw_)readl/writel with lighter
    *_relaxed variants
  watchdog/mpcore_wdt: Add support for WDIOC_GETBOOTSTATUS IOCTL
  watchdog/mpcore_wdt: Add clock framework support
  watchdog/mpcore_wdt: use correct clk_rate to program timeout
  watchdog/mpcore_wdt: Start registers from 0x00 instead of 0x20
  watchdog/mpcore_wdt: Add DT probing support for ARM mpcore watchdog

 arch/arm/include/asm/smp_twd.h |   7 -
 drivers/watchdog/Kconfig       |   3 +-
 drivers/watchdog/mpcore_wdt.c  | 529 ++++++++++++++++++++---------------------
 3 files changed, 256 insertions(+), 283 deletions(-)

-- 
1.7.12.rc2.18.g61b472e
