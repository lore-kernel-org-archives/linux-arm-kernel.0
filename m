From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 27 Nov 2014 13:07:30 +0800
Subject: [PATCH v2 0/3] cleanups for converting apic_id to phys_id to make it
 arch agnostic
Message-ID: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some cleanups to convert apic_id to phys_id to accommodate
ACPI 5.0+.

updates since v1:
 - rebase on top of linux-next git repo to slove the conflicts
   with IOAPIC hotplug patch
 - modify patch 2 to update the comments and print message using
   arch independent words instead of APIC

Hanjun Guo (3):
  ACPI / processor: Update the comments in processor.h
  ACPI / processor: Convert apic_id to phys_id to make it arch agnostic
  ACPI / processor: Rename acpi_(un)map_lsapic() to acpi_(un)map_cpu()

 arch/ia64/kernel/acpi.c       |  9 ++++---
 arch/x86/kernel/acpi/boot.c   |  9 ++++---
 drivers/acpi/acpi_processor.c | 25 ++++++++++---------
 drivers/acpi/processor_core.c | 56 +++++++++++++++++++++----------------------
 include/acpi/processor.h      | 12 ++++++----
 include/linux/acpi.h          |  4 ++--
 6 files changed, 59 insertions(+), 56 deletions(-)

-- 
1.9.1
