From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 14 Apr 2016 19:42:31 -0700
Subject: [PATCH v2 0/6] ARM/ARM64: Drop arm_pm_restart
Message-ID: <1460688157-6551-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the final push to replace arm_pm_restart with the kernel restart
handler. Finally drop arm_pm_restart after it is no longer used.

---
v2: Rebased to v4.6-rc3
    Added Reviewed-by/Acked/by/Tested-by tags
    Variable name change in patch 3/6.

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
