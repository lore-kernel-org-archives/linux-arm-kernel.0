From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Wed, 21 Jun 2017 11:45:41 +0530
Subject: [PATCH v3 0/2] acpi, gicv3-its, numa: Adding numa node mapping for ITS
Message-ID: <1498025743-6340-1-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI 6.2 have added SRAT subtable to define proximity domain for ITS
devices. This patchset updates acpi header file from acpica repo and
adds numa node mapping for ITS devices.

v3:
  - Use static array to stash parsed data from srat its table.

v2:
 - Incorporated comments from Lorenzo Pieralisi and Marc Zyngier.

v1: first patch

Ganapatrao Kulkarni (2):
  ACPICA: ACPI 6.2: Add support for new SRAT subtable
  acpi, gicv3-its, numa: Adding numa node mapping for gic-its units

 drivers/irqchip/irq-gic-v3-its.c | 80 +++++++++++++++++++++++++++++++++++++++-
 include/acpi/actbl1.h            | 12 +++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

-- 
1.8.1.4
