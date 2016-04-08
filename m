From: linux@roeck-us.net (Guenter Roeck)
Date: Fri,  8 Apr 2016 05:53:53 -0700
Subject: [PATCH 0/6] ARM/ARM64: Drop arm_pm_restart
Message-ID: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the final push to replace arm_pm_restart with the kernel restart
handler. Finally drop arm_pm_restart after it is no longer used.
The following changes since commit 541d8f4d59d79f5d37c8c726f723d42ff307db57:

----------------------------------------------------------------
Guenter Roeck (6):
      ARM: prima2: Register with kernel restart handler
      ARM: xen: Register with kernel restart handler
      ARM: PSCI: Register with kernel restart handler
      ARM: Register with kernel restart handler
      ARM64: Remove arm_pm_restart
      ARM: Remove arm_pm_restart

 arch/arm/include/asm/system_misc.h   |  1 -
 arch/arm/kernel/reboot.c             |  6 +-----
 arch/arm/kernel/setup.c              | 20 ++++++++++++++++++--
 arch/arm/mach-prima2/rstc.c          | 11 +++++++++--
 arch/arm/xen/enlighten.c             | 13 +++++++++++--
 arch/arm64/include/asm/system_misc.h |  2 --
 arch/arm64/kernel/process.c          |  7 +------
 drivers/firmware/psci.c              | 11 +++++++++--
 8 files changed, 49 insertions(+), 22 deletions(-)
