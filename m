From: labbott@redhat.com (Laura Abbott)
Date: Tue, 18 Oct 2016 15:01:27 -0700
Subject: [PATCHv3 0/4] WX checking for arm64
Message-ID: <1476828091-17802-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 of the implementation to check for writable and executable pages on
arm64. This is a basically a rebase + acks.

Laura Abbott (4):
  arm64: dump: Make ptdump debugfs a separate option
  arm64: dump: Make the page table dumping seq_file optional
  arm64: dump: Remove max_addr
  arm64: dump: Add checking for writable and exectuable pages

 arch/arm64/Kconfig.debug           |  35 ++++++++++++-
 arch/arm64/include/asm/ptdump.h    |  22 +++++---
 arch/arm64/mm/Makefile             |   3 +-
 arch/arm64/mm/dump.c               | 104 +++++++++++++++++++++++++++----------
 arch/arm64/mm/mmu.c                |   2 +
 arch/arm64/mm/ptdump_debugfs.c     |  31 +++++++++++
 drivers/firmware/efi/arm-runtime.c |   5 +-
 7 files changed, 163 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/mm/ptdump_debugfs.c

-- 
2.7.4
