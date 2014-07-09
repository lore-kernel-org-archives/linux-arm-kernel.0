From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed,  9 Jul 2014 17:39:03 +0800
Subject: [PATCH v2 0/3] Clean up ACPI core to prepare for running ACPI on ARM64
Message-ID: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set have no function change for x86 and ia64 and
just do some clean up to prepare for running ACPI on ARM64.

This patch set is splited out from the patch set [1]
"[PATCH v4 00/13] Enable ACPI on ARM64 in Kconfig" and hope it
can be merged first before ARM64 ACPI core patches.

[1]: https://lkml.org/lkml/2014/6/26/627

update from v1:
1. Drop "Make EC debugfs depend on X86 || IA64 in Kconfig";
2. Rename ACPI_SCAN_BIOS_NOT_EFI to ACPI_LEGACY_TABLES_LOOKUP
   suggested by Rafael;
3. Rename ARCH_HAS_ACPI_PDC to ARCH_MIGHT_HAVE_ACPI_PDC suggested by Rafael;
4. Remove the help for ARCH_MIGHT_HAVE_ACPI_PDC because it can't be selected;
5. Rename acpi_arch_is_smp() to acpi_has_cpu_in_madt() to be more
   explicit and easy understanding.

Graeme Gregory (2):
  ACPI: ARM64 does not have a BIOS add config for BIOS table scan.
  ACPI: Don't use acpi_lapic in ACPI core code

Hanjun Guo (1):
  ACPI / processor: Introduce ARCH_HAS_ACPI_PDC

 arch/ia64/Kconfig             |    2 +
 arch/ia64/include/asm/acpi.h  |    5 +
 arch/x86/Kconfig              |    2 +
 arch/x86/include/asm/acpi.h   |    5 +
 drivers/acpi/Kconfig          |    6 ++
 drivers/acpi/Makefile         |    1 +
 drivers/acpi/acpi_processor.c |    2 +-
 drivers/acpi/internal.h       |    5 +
 drivers/acpi/osl.c            |    4 +-
 drivers/acpi/processor_core.c |  198 ---------------------------------------
 drivers/acpi/processor_pdc.c  |  206 +++++++++++++++++++++++++++++++++++++++++
 11 files changed, 236 insertions(+), 200 deletions(-)
 create mode 100644 drivers/acpi/processor_pdc.c

-- 
1.7.9.5
