From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  2 Feb 2016 18:56:39 +0100
Subject: [RFC PATCH 0/3] arm64 initrd mapping/relocation
Message-ID: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After discussing in linux-efi with Mark, and on #armlinux with Will, this is
a proposal for dealing with initrd memory that is potentially not covered by
the linear region.

Note that this will look slightly differently when some of the KASLR work gets
merged, but this should only affect the way we deal with the initrd if it sits
outside of the linear region.

Mostly intended for discussion, not tested at all.

Ard Biesheuvel (3):
  memblock: add routine to clear the MEMBLOCK_NOMAP flag for a region
  arm64: add the initrd region to the linear mapping explicitly
  arm64: remove the now unneeded relocate_initrd()

 arch/arm64/kernel/setup.c | 64 --------------------
 arch/arm64/mm/init.c      | 16 ++++-
 include/linux/memblock.h  |  1 +
 mm/memblock.c             | 12 ++++
 4 files changed, 27 insertions(+), 66 deletions(-)

-- 
2.5.0
