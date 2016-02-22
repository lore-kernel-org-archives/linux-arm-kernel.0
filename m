From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 11:00:36 +0100
Subject: [PATCH 0/3] arm64 pt dumper changes
Message-ID: <1456135239-3607-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series updates the kernel page table dumper to:
- not initialize the vmemmap region markers dynamically
- show region boundaries for the kasan shadow region
- include the UEFI runtime services mappings

Ard Biesheuvel (3):
  arm64: ptdump: use static initializers for vmemmap region boundaries
  arm64: ptdump: add region marker for kasan shadow region
  arm64: ptdump: include UEFI runtime service mappings

 arch/arm64/mm/dump.c               | 58 ++++++++------------
 drivers/firmware/efi/arm-runtime.c |  2 +-
 2 files changed, 24 insertions(+), 36 deletions(-)

-- 
2.5.0
