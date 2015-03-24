From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 24 Mar 2015 17:58:50 +0000
Subject: [PATCH 0/5] ARM64: ACPI core updates
Message-ID: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements some refactoring/clean-ups of arm64 ACPI
core code implemented in Hanjun Guo's series:

http://www.spinics.net/lists/kernel/msg1953211.html

available at:

git://git.linaro.org/leg/acpi/acpi.git acpi-5.1-v11

Patch [1] is a proposal to move the arm64 GSI IRQ mapping layer to generic
ACPI code, in that the arm64 GSI layer is based on IRQ domains that are
generic data structures in the kernel that are not tied to an arch specific
implementation.

Patches [2-5] implement some fixes/clean-up of arm64 ACPI core code.

Tested on Juno v8 chip.

Lorenzo Pieralisi (5):
  ACPI: move arm64 GSI IRQ model to generic GSI IRQ layer
  ARM64: kernel: psci: factor out probe function
  ARM64: kernel: psci: let ACPI probe PSCI version
  ARM64: kernel: acpi: refactor ACPI tables init and checks
  ARM64: kernel: acpi: honour acpi=force command line parameter

 arch/arm64/Kconfig            |   1 +
 arch/arm64/include/asm/acpi.h |   3 -
 arch/arm64/kernel/acpi.c      | 167 +++++++++++++++++-------------------------
 arch/arm64/kernel/psci.c      |  54 +++++++++-----
 arch/arm64/kernel/setup.c     |   2 +-
 drivers/acpi/Kconfig          |   3 +
 drivers/acpi/Makefile         |   1 +
 drivers/acpi/gsi.c            | 105 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c     |   2 +
 9 files changed, 214 insertions(+), 124 deletions(-)
 create mode 100644 drivers/acpi/gsi.c

-- 
2.2.1
