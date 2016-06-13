From: liudongdong3@huawei.com (Dongdong Liu)
Date: Mon, 13 Jun 2016 21:02:01 +0800
Subject: [RFC PATCH V2 0/2] ECAM quirks handling for ARM64 platforms
Message-ID: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series bases on pending ACPI PCI support for ARM64:
https://lkml.org/lkml/2016/6/10/706

Quirk handling relies on an idea of matching MCFG OEM ID and OEM TABLE ID
(the ones from standard header of MCFG table). Linker section is used
so that quirks can be registered using special macro (see patches) and
kept self contained.

v1 -> v2
- use oem_id and oem_table_id to replace oem_id and oem_revision to make 
  a difference between different platforms.
- change pci_cfg_fixup __mcfg_fixup_##system##dom##bus to
  __mcfg_fixup_##oem_id##oem_table_id##dom##bus. With oem_id and oem_table_id
  is to ensure that the object is unique.

Tomasz Nowicki (2):
  ACPI/PCI: Match PCI config space accessors against platfrom specific
    ECAM quirks
  ARM64/PCI: Start using quirks handling for ACPI based PCI host
    controller

 arch/arm64/kernel/pci.c           |  7 ++++---
 drivers/acpi/pci_mcfg.c           | 41 ++++++++++++++++++++++++++++++++++++---
 include/asm-generic/vmlinux.lds.h |  7 +++++++
 include/linux/pci-acpi.h          | 20 +++++++++++++++++++
 4 files changed, 69 insertions(+), 6 deletions(-)

-- 
1.9.1
