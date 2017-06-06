From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue,  6 Jun 2017 18:26:25 +0530
Subject: [PATCH 0/2] acpi, gicv3-its, numa: Adding numa node mapping for its
Message-ID: <1496753787-27735-1-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI 6.2 have added SRAT subtable to define proximity domain for ITS
devices. This patchset Updates acpi header file from acpica repo and
adds numa node mapping for its devices.

Ganapatrao Kulkarni (2):
  ACPICA: ACPI 6.2: Add support for new SRAT subtable
  acpi, gicv3-its, numa: Adding numa node mapping for gic-its devices

 arch/arm64/include/asm/acpi.h    |  2 ++
 arch/arm64/kernel/acpi_numa.c    | 59 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/numa.c              | 32 +++++++++++++++++++++-
 drivers/irqchip/irq-gic-v3-its.c |  3 +-
 include/acpi/actbl1.h            | 12 +++++++-
 include/linux/acpi.h             |  3 ++
 6 files changed, 108 insertions(+), 3 deletions(-)

-- 
1.8.1.4
