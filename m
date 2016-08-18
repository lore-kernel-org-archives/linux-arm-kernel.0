From: geoff@infradead.org (Geoff Levand)
Date: Thu, 18 Aug 2016 18:21:02 +0000
Subject: [PATCH v4 0/3] arm64 kexec-tools patches
Message-ID: <cover.1471543843.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the core support for kexec re-boot on ARM64.

Linux kernel support for ARM64 kexec reboot has been merged in v4.8-rc1 with the
expectation that it will be included in the v4.8 stable kernel release.

For ARM64 kdump support see Takahiro's latest kdump patches [1].

[1] http://lists.infradead.org/pipermail/kexec/2016-August/016779.html

Changes for v4 (Aug 18, 2016, 1m):

  o Fix some error return values and error messages.
  o Add enum arm64_header_page_size.
  o Rename page_offset to vp_offset.

Changes for v3 (Aug 10, 2016, 1m):

  o Rebase to 2.0.13.
  o Add support for flag bits 1-3 to arm64 image-header.h.
  o Fix OPT_ARCH_MAX value.
  o Use fdt_pack() in dtb_set_property().
  o Remove patch ("kexec: (bugfix) calc correct end address of memory ranges in device tree").

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

The following changes since commit 67488beb0a6ee8ad2c0b05f721a9e00041fab93a:

  kexec-tools 2.0.13 (2016-08-08 12:26:44 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git for-merge-arm64-v4

for you to fetch changes up to 7b17bc40e62e90fd92207d4385a0a99aec958d26:

  arm64: Add support for binary image files (2016-08-18 11:09:39 -0700)

----------------------------------------------------------------
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
 kexec/arch/arm64/image-header.h         | 146 +++++++
 kexec/arch/arm64/include/arch/options.h |  39 ++
 kexec/arch/arm64/kexec-arm64.c          | 705 ++++++++++++++++++++++++++++++++
 kexec/arch/arm64/kexec-arm64.h          |  70 ++++
 kexec/arch/arm64/kexec-elf-arm64.c      | 132 ++++++
 kexec/arch/arm64/kexec-image-arm64.c    |  60 +++
 kexec/dt-ops.c                          | 145 +++++++
 kexec/dt-ops.h                          |  13 +
 kexec/kexec-syscall.h                   |   8 +-
 purgatory/Makefile                      |   1 +
 purgatory/arch/arm64/Makefile           |  18 +
 purgatory/arch/arm64/entry.S            |  51 +++
 purgatory/arch/arm64/purgatory-arm64.c  |  19 +
 18 files changed, 1486 insertions(+), 2 deletions(-)
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
2.7.4
