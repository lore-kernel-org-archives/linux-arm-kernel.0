From: labbott@redhat.com (Laura Abbott)
Date: Thu, 27 Oct 2016 09:27:30 -0700
Subject: [PATCHv4 0/4] WX checking for arm64
Message-ID: <1477585654-8908-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v4 of the implementation to check for writable and executable pages on
arm64. This version contains a review from Ard and makes the UXN page count
a separate variable. Overall, minor changes.

Thanks,
Laura

Laura Abbott (4):
  arm64: dump: Make ptdump debugfs a separate option
  arm64: dump: Make the page table dumping seq_file optional
  arm64: dump: Remove max_addr
  arm64: dump: Add checking for writable and exectuable pages

 arch/arm64/Kconfig.debug           |  35 ++++++++++++-
 arch/arm64/include/asm/ptdump.h    |  22 +++++---
 arch/arm64/mm/Makefile             |   3 +-
 arch/arm64/mm/dump.c               | 105 +++++++++++++++++++++++++++----------
 arch/arm64/mm/mmu.c                |   2 +
 arch/arm64/mm/ptdump_debugfs.c     |  31 +++++++++++
 drivers/firmware/efi/arm-runtime.c |   4 +-
 7 files changed, 164 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/mm/ptdump_debugfs.c

-- 
2.7.4
