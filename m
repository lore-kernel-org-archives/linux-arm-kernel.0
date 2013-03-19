From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Mar 2013 18:06:38 +0000
Subject: [PATCH 0/2] More 'generic' vexpress poweroff/restart driver
Message-ID: <1363716400-9002-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches move the vexpress poweroff/restart code to
driver/power/reset/ so that it can be used on arm64. The only
non-generic feature is the setting of the arm_pm_restart variable but I
can probably live with this under arm64.

Thanks.


Catalin Marinas (2):
  arm: vexpress: Move the poweroff/restart code to drivers/power/reset
  arm: vexpress: Decouple vexpress-poweroff implementation from
    machine_desc

 arch/arm/mach-vexpress/Kconfig                                   | 3 +++
 arch/arm/mach-vexpress/Makefile                                  | 2 +-
 arch/arm/mach-vexpress/v2m.c                                     | 5 -----
 drivers/power/reset/Kconfig                                      | 7 +++++++
 drivers/power/reset/Makefile                                     | 3 ++-
 .../reset.c => drivers/power/reset/vexpress-poweroff.c           | 9 +++++++--
 include/linux/vexpress.h                                         | 3 ---
 7 files changed, 20 insertions(+), 12 deletions(-)
 rename arch/arm/mach-vexpress/reset.c => drivers/power/reset/vexpress-poweroff.c (93%)
