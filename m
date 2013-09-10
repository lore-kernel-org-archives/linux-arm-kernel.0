From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 10 Sep 2013 18:59:45 +0100
Subject: [PATCH 0/4] cpufreq: fixes for v3.12
Message-ID: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi Shawn, Guennadi,

These are the fixes for the issue reported by Guennadi.
cpu_dev should point to cpu0 device instead of cpufreq-cpu0 platform
devices. The dev_id is also updated while registering the cpu clocks.

Can you review these ? Tested-by is much appreciated as I don't
have hardware to check the fix.

Regards,
Sudeep

Sudeep KarkadaNagesha (4):
  cpufreq: cpufreq-cpu0: assign cpu_dev correctly to cpu0 device
  cpufreq: imx6q-cpufreq: assign cpu_dev correctly to cpu0 device
  ARM: i.MX: change dev_id to cpu0 while registering cpu clock
  ARM: shmobile: change dev_id to cpu0 while registering cpu clock

 arch/arm/mach-imx/clk-imx27.c          | 2 +-
 arch/arm/mach-imx/clk-imx51-imx53.c    | 2 +-
 arch/arm/mach-imx/mach-imx6q.c         | 9 +++++++--
 arch/arm/mach-shmobile/clock-r8a73a4.c | 2 +-
 arch/arm/mach-shmobile/clock-sh73a0.c  | 2 +-
 drivers/cpufreq/cpufreq-cpu0.c         | 7 ++++++-
 drivers/cpufreq/imx6q-cpufreq.c        | 7 ++++++-
 7 files changed, 23 insertions(+), 8 deletions(-)

-- 
1.8.1.2
