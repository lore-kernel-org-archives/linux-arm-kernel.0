From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 15 Feb 2016 12:32:31 +0100
Subject: [PATCH v2 0/2] efi: ARM/arm64: wire up ESRT table
Message-ID: <1455535953-5056-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by Tyler, the ESRT support was not wired up yet for ARM or
arm64, hence this series.

Patch #1 replaces ioremap with memremap in the generic ESRT support, since
what we are mapping is not I/O, and this does make a difference on ARM/arm64

Patch #2 adds the missing efi_esrt_init() call, and tweaks some memmap fields
that efi_mem_desc_lookup() expects.

Ard Biesheuvel (2):
  efi: esrt: use memremap not ioremap to access ESRT table in memory
  arm64/efi: esrt: add missing call to efi_esrt_init()

 drivers/firmware/efi/arm-init.c |  3 +++
 drivers/firmware/efi/esrt.c     | 16 ++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.5.0
