From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jan 2017 12:05:06 +0100
Subject: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
Message-ID: <20170130110512.6943-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Hi everyone,

This small series is preparatory work for a series that I'm working on
which attempts to establish a formal framework for system restart and
power off.

Guenter has done a lot of good work in this area, but it never got
merged. I think this set is a valuable addition to the kernel because
it converts all odd providers to the established mechanism for restart.

Since this is stretched across both 32-bit and 64-bit ARM, as well as
PSCI, and given the SoC/board level of functionality, I think it might
make sense to take this through the ARM SoC tree in order to simplify
the interdependencies. But it should also be possible to take patches
1-4 via their respective trees this cycle and patches 5-6 through the
ARM and arm64 trees for the next cycle, if that's preferred.

Thanks,
Thierry

Guenter Roeck (6):
  ARM: prima2: Register with kernel restart handler
  ARM: xen: Register with kernel restart handler
  drivers: firmware: psci: Register with kernel restart handler
  ARM: Register with kernel restart handler
  ARM64: Remove arm_pm_restart()
  ARM: Remove arm_pm_restart()

 arch/arm/include/asm/system_misc.h   |  1 -
 arch/arm/kernel/reboot.c             |  6 +-----
 arch/arm/kernel/setup.c              | 20 ++++++++++++++++++--
 arch/arm/mach-prima2/rstc.c          | 11 +++++++++--
 arch/arm/xen/enlighten.c             | 13 +++++++++++--
 arch/arm64/include/asm/system_misc.h |  2 --
 arch/arm64/kernel/process.c          |  7 +------
 drivers/firmware/psci.c              | 11 +++++++++--
 8 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.11.0
