From: geoff@infradead.org (Geoff Levand)
Date: Tue, 26 Jul 2016 20:18:56 +0000
Subject: [PATCH v2 0/4] arm64 kexec-tools patches
Message-ID: <cover.1469559530.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the core support for kexec re-boot on ARM64.

Linux kernel support for kexec reboot [1] has been merged to the ARM64
for-next/core branch with the expectation that it will be included in the v4.8
stable kernel release.

For ARM64 kdump support see Takahiro's patches [2].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html
[2] http://lists.infradead.org/pipermail/kexec/2016-July/016642.html

Changes for v2 (July 26, 2016, 0m):

  o Inline some small routines.
  o Reformat some dbgprintf messages.
  o Remove debug_brk from entry.S
  o Change arm64_image_header.flags to uint64_t.
  o Look in iomem then dt for mem info.
  o Remove check_cpu_nodes.
  o Remove purgatory printing.

First submission v1 (July 20, 2016).

-Geoff

The following changes since commit 8d614008609f6ad5d09263767ebc771e06a173f0:

  arm: use zImage size from header (2016-07-15 13:12:28 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git for-merge-arm64-v2

for you to fetch changes up to f352dcfc827a4cbb3878dd1043877a4154b1bd08:

  arm64: Add support for binary image files (2016-07-26 11:48:01 -0700)

----------------------------------------------------------------
AKASHI Takahiro (1):
      kexec: (bugfix) calc correct end address of memory ranges in device tree

Geoff Levand (2):
      kexec: Add common device tree routines
      arm64: Add arm64 kexec support

Pratyush Anand (1):
      arm64: Add support for binary image files

 configure.ac                            |   3 +
 kexec/Makefile                          |   5 +
 kexec/arch/arm64/Makefile               |  40 ++
 kexec/arch/arm64/crashdump-arm64.c      |  21 +
 kexec/arch/arm64/crashdump-arm64.h      |  12 +
 kexec/arch/arm64/image-header.h         |  98 +++++
 kexec/arch/arm64/include/arch/options.h |  39 ++
 kexec/arch/arm64/kexec-arm64.c          | 704 ++++++++++++++++++++++++++++++++
 kexec/arch/arm64/kexec-arm64.h          |  70 ++++
 kexec/arch/arm64/kexec-elf-arm64.c      | 130 ++++++
 kexec/arch/arm64/kexec-image-arm64.c    |  63 +++
 kexec/dt-ops.c                          | 139 +++++++
 kexec/dt-ops.h                          |  13 +
 kexec/fs2dt.c                           |   5 +-
 kexec/kexec-syscall.h                   |   8 +-
 purgatory/Makefile                      |   1 +
 purgatory/arch/arm64/Makefile           |  18 +
 purgatory/arch/arm64/entry.S            |  51 +++
 purgatory/arch/arm64/purgatory-arm64.c  |  19 +
 19 files changed, 1435 insertions(+), 4 deletions(-)
 create mode 100644 kexec/arch/arm64/Makefile
 create mode 100644 kexec/arch/arm64/crashdump-arm64.c
 create mode 100644 kexec/arch/arm64/crashdump-arm64.h
 create mode 100644 kexec/arch/arm64/image-header.h
 create mode 100644 kexec/arch/arm64/include/arch/options.h
 create mode 100644 kexec/arch/arm64/kexec-arm64.c
 create mode 100644 kexec/arch/arm64/kexec-arm64.h
 create mode 100644 kexec/arch/arm64/kexec-elf-arm64.c
 create mode 100644 kexec/arch/arm64/kexec-image-arm64.c
 create mode 100644 kexec/dt-ops.c
 create mode 100644 kexec/dt-ops.h
 create mode 100644 purgatory/arch/arm64/Makefile
 create mode 100644 purgatory/arch/arm64/entry.S
 create mode 100644 purgatory/arch/arm64/purgatory-arm64.c

-- 
2.5.0
