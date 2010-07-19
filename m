From: kirill@shutemov.name (Kirill A. Shutsemov)
Date: Mon, 19 Jul 2010 11:53:20 +0300
Subject: [PATCH 0/5] ARM: fix exceptions handling
Message-ID: <cover.1279529223.git.kirill@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kirill A. Shutemov <kirill@shutemov.name>

Kirill A. Shutemov (5):
  Use SIGBUS for unalinged access instead of SIGILL
  Add 'code' parameter for hook_fault_code()
  Check arch version and modify fsr_info[] depends on it at runtime
  ARMv6K and ARMv7 use fault statuses 3 and 6 as Access Flag fault
  Workaround infinity loop in handling of translation faults

 arch/arm/include/asm/system.h     |    2 +-
 arch/arm/mach-integrator/pci_v3.c |    8 ++--
 arch/arm/mach-iop13xx/pci.c       |    2 +-
 arch/arm/mach-ixp2000/pci.c       |    2 +-
 arch/arm/mach-ixp23xx/pci.c       |    2 +-
 arch/arm/mach-ixp4xx/common-pci.c |    3 +-
 arch/arm/mach-ks8695/pci.c        |    4 +-
 arch/arm/mm/alignment.c           |   16 +++++++++-
 arch/arm/mm/fault.c               |   56 +++++++++++++++++++++++++++---------
 arch/arm/plat-iop/pci.c           |    2 +-
 10 files changed, 69 insertions(+), 28 deletions(-)
