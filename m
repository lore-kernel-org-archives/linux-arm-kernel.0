From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 16:40:27 +0100
Subject: [PATCH v2 00/10] Prevent list poison values from being mapped by
 userspace processes
Message-ID: <20150825154026.GT7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's v2 of the uaccess patches, with the comments raised so far
addressed.  As such, it's grown a tad more than the previous set of
patches.

 arch/arm/Kconfig                            | 15 +++++
 arch/arm/include/asm/assembler.h            | 47 ++++++++++++++++
 arch/arm/include/asm/domain.h               | 53 ++++++++++++++----
 arch/arm/include/asm/futex.h                | 19 ++++++-
 arch/arm/include/asm/pgtable-2level-hwdef.h |  1 +
 arch/arm/include/asm/thread_info.h          |  3 -
 arch/arm/include/asm/uaccess.h              | 85 +++++++++++++++++++++++++++--
 arch/arm/kernel/armksyms.c                  |  6 +-
 arch/arm/kernel/entry-armv.S                | 32 ++++++++---
 arch/arm/kernel/entry-common.S              |  2 +
 arch/arm/kernel/entry-header.S              |  5 ++
 arch/arm/kernel/head.S                      |  5 +-
 arch/arm/kernel/process.c                   | 37 ++++++++++---
 arch/arm/kernel/traps.c                     |  1 -
 arch/arm/lib/clear_user.S                   |  6 +-
 arch/arm/lib/copy_from_user.S               |  6 +-
 arch/arm/lib/copy_to_user.S                 |  6 +-
 arch/arm/lib/csumpartialcopyuser.S          | 14 +++++
 arch/arm/lib/uaccess_with_memcpy.c          |  4 +-
 arch/arm/mm/abort-ev4.S                     |  1 +
 arch/arm/mm/abort-ev5t.S                    |  4 +-
 arch/arm/mm/abort-ev5tj.S                   |  4 +-
 arch/arm/mm/abort-ev6.S                     |  8 ++-
 arch/arm/mm/abort-ev7.S                     |  1 +
 arch/arm/mm/abort-lv4t.S                    |  2 +
 arch/arm/mm/abort-macro.S                   | 14 ++---
 arch/arm/mm/mmu.c                           |  4 +-
 arch/arm/mm/pgd.c                           | 10 ++++
 28 files changed, 324 insertions(+), 71 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
