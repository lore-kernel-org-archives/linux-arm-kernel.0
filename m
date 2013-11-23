From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:34:10 -0500
Subject: [PATCH 0/3] ARM: mm: Switch ARM port to NO_BOOTMEM
Message-ID: <1385249653-9250-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now with dma_mask series merged and max*pfn has consistent meaning on ARM
as rest of the arch's thanks to RMK's mega series, lets switch ARM code
to NO_BOOTMEM. With NO_BOOTMEM change, now we use memblock allocator to
reserve space for crash kernel to have one less dependency with nobootmem
allocator wrapper.

Tested with both flat memory and sparse (faked) memory models with highmem

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@linaro.org>

Grygorii Strashko (1):
  ARM: mm: Don't allow resizing of memblock data until "low" memory is
    not mapped

Santosh Shilimkar (2):
  ARM: mm: Fix max_mapnr with recent max*pfn updates
  ARM: mm: Remove bootmem code and switch to NO_BOOTMEM

 arch/arm/Kconfig        |    1 +
 arch/arm/kernel/setup.c |    2 +-
 arch/arm/mm/init.c      |   62 +++--------------------------------------------
 3 files changed, 6 insertions(+), 59 deletions(-)

-- 
1.7.9.5
