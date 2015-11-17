From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Tue, 17 Nov 2015 23:55:29 +0530
Subject: [PATCH v2 0/4] ACPI based NUMA support for ARM64
Message-ID: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 -v2 rebased on arm64-numa v7 patches.
 http://www.spinics.net/lists/arm-kernel/msg460813.html

 -v1 initial patches from Hanjun Guo

Hanjun Guo (4):
  acpi, numa: Use pr_fmt() instead of printk
  acpi, numa: Replace ACPI_DEBUG_PRINT() with pr_debug()
  arm64, acpi, numa: NUMA support based on SRAT and SLIT
  acpi, numa: Enable ACPI based NUMA on ARM64

 arch/arm64/include/asm/acpi.h |   4 +
 arch/arm64/kernel/Makefile    |   1 +
 arch/arm64/kernel/acpi_numa.c | 215 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/numa.c          |   7 +-
 drivers/acpi/Kconfig          |   4 +-
 drivers/acpi/numa.c           | 106 ++++++++++++---------
 include/linux/acpi.h          |  15 +++
 7 files changed, 306 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm64/kernel/acpi_numa.c

-- 
1.8.1.4
