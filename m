From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Tue, 17 May 2016 15:06:00 +0300
Subject: [PATCH 0/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
Message-ID: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for ACPI_TABLE_UPGRADE for ARM64

It refactors the code introduced by the patches by Lv Zheng [1], fixes access to
the destination of new ACPI tables as suggested by Mark Rutland [2] and enables
the feature for ARM64

It was first sent by Jon Masters [3] to linaro-acpi in December 2015

Tested on QEMU (arm64 and x86) and ThunderX
Should be applied to next-20160517

[1] https://lkml.kernel.org/g/cover.1460340514.git.lv.zheng at intel.com
[2] https://lists.linaro.org/pipermail/linaro-acpi/2015-December/006101.html
[3] https://lists.linaro.org/pipermail/linaro-acpi/2015-December/006099.html

Aleksey Makarov (2):
  ACPI: table upgrade: use cacheable map for tables
  ACPI: table upgrade: move early_initrd_acpi_init() to header file

Jon Masters (1):
  ACPI: ARM64: support for ACPI_TABLE_UPGRADE

 arch/arm64/kernel/setup.c |  6 ++++--
 arch/x86/kernel/setup.c   |  7 -------
 drivers/acpi/Kconfig      |  2 +-
 drivers/acpi/tables.c     | 21 ++++++++++++++++-----
 include/linux/acpi.h      |  4 ++--
 5 files changed, 23 insertions(+), 17 deletions(-)

-- 
2.8.2
