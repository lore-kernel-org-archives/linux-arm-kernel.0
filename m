From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Tue, 24 Mar 2015 17:49:02 +0300
Subject: [PATCH 0/2] KASan for arm64
Message-ID: <1427208544-8232-1-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This adds KASan for arm64.
First patch is a small prep, all major changes in the second.

It was lightly tested in qemu.
I should get a real hardware quite soon to test this.

TODO:
	Add more interceptors for memory accessing functions (memcmp, strlen, ...),
	though this could be done later.


Andrey Ryabinin (2):
  kasan, x86: move KASAN_SHADOW_OFFSET to the arch Kconfig
  arm64: add KASan support

 arch/arm64/Kconfig                   |   7 ++
 arch/arm64/include/asm/pgtable.h     |   3 +-
 arch/arm64/include/asm/string.h      |  16 +++
 arch/arm64/include/asm/thread_info.h |   8 ++
 arch/arm64/kernel/head.S             |   3 +
 arch/arm64/kernel/module.c           |  16 ++-
 arch/arm64/kernel/setup.c            |   2 +
 arch/arm64/lib/memcpy.S              |   3 +
 arch/arm64/lib/memmove.S             |   7 +-
 arch/arm64/lib/memset.S              |   3 +
 arch/arm64/mm/Makefile               |   3 +
 arch/arm64/mm/kasan_init.c           | 211 +++++++++++++++++++++++++++++++++++
 arch/x86/Kconfig                     |   4 +
 lib/Kconfig.kasan                    |   4 -
 14 files changed, 280 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/mm/kasan_init.c

-- 
2.3.3
