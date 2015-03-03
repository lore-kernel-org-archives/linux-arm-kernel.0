From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  3 Mar 2015 12:03:45 +0100
Subject: [PATCH 0/5] arm64: update/clarify/relax Image and FDT placement rules
Message-ID: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series came about after Mark Rutland brought up the fact that the current
FDT placement logic used by the EFI stub is flawed. But actually, it turned out
that the documentation for both the Image and FDT placement was incorrect as
well, or confusing at the very least.

So this series does two things:
- It relaxes the FDT placement requirements, and updates the documentation and
  EFI stub FDT placement logic accordingly.
- It clarifies the Image placement requirements in the documentation, and brings
  the EFI stub Image placement logic in line with it

Ard Biesheuvel (5):
  of/fdt: allow FDT virtual address outside of linear direct mapping
  arm64: use fixmap region for permanent FDT mapping
  arm64: Documentation: clarify Image placement in physical RAM
  arm64/efi: ensure that Image does not cross a 512 MB boundary
  arm64/efi: adapt to relaxed FDT placement requirements

 Documentation/arm64/booting.txt         | 12 +++----
 arch/arm64/include/asm/efi.h            |  9 +++--
 arch/arm64/include/asm/fixmap.h         |  9 +++++
 arch/arm64/kernel/Makefile              |  1 +
 arch/arm64/kernel/efi-stub.c            | 38 ++++++++++++++++----
 arch/arm64/kernel/head.S                | 38 +-------------------
 arch/arm64/kernel/setup.c               | 62 +++++++++++++++++++++++++++++----
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 drivers/firmware/efi/libstub/fdt.c      |  7 ++--
 drivers/of/fdt.c                        | 14 +++++++-
 10 files changed, 125 insertions(+), 67 deletions(-)

-- 
1.8.3.2
