From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 Jan 2016 12:07:31 +0100
Subject: [PATCH 0/3] arm efi minor fixes
Message-ID: <1453979254-25374-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes two minor issues with the handling of .init data in the stub (#1, #2)

Patch #3 replaces some instances of early_memremap() with early_memremap_ro()
where the region in question is only accessed in r/o mode.

Ard Biesheuvel (3):
  arm64: efistub: drop __init annotation from handle_kernel_image()
  arm64: vmlinux.lds.S: handle .init.rodata.xxx and .init.bss sections
  efi: arm-init: use read-only early mappings

 arch/arm64/kernel/vmlinux.lds.S           |  1 +
 drivers/firmware/efi/arm-init.c           | 14 +++++++-------
 drivers/firmware/efi/libstub/arm64-stub.c | 14 +++++++-------
 3 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.5.0
