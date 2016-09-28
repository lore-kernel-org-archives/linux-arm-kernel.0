From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 28 Sep 2016 18:05:14 +0200
Subject: [PATCH v6 0/3] arm64 kexec-tools patches
In-Reply-To: <cover.1474481332.git.geoff@infradead.org>
References: <cover.1474481332.git.geoff@infradead.org>
Message-ID: <f1331028-e20b-50a3-fdeb-1e24861c7f29@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/09/16 20:14, Geoff Levand wrote:
> This series adds the core support for kexec re-boot on ARM64.
>

I also tested on seattle.

Tested-By: Matthias Brugger <mbrugger@suse.com>

> Linux kernel support for ARM64 kexec reboot has been merged in v4.8-rc1 with the
> expectation that it will be included in the v4.8 stable kernel release.
>
> For ARM64 kdump support see Takahiro's latest kdump patches [1].
>
> [1] http://lists.infradead.org/pipermail/kexec
>
> Changes for v6 (Sep , 2016, 2m):
>
>   o Remove the get_memory_ranges_dt() routine.
>   o Rename dtb_[12] to dtb_{proc,sys,user}.
>
> Changes for v5 (Sep 1, 2016, 2m):
>
>   o Add common routine arm64_locate_kernel_segment().
>
> Changes for v4 (Aug 18, 2016, 1m):
>
>   o Fix some error return values and error messages.
>   o Add enum arm64_header_page_size.
>   o Rename page_offset to vp_offset.
>
> Changes for v3 (Aug 10, 2016, 1m):
>
>   o Rebase to 2.0.13.
>   o Add support for flag bits 1-3 to arm64 image-header.h.
>   o Fix OPT_ARCH_MAX value.
>   o Use fdt_pack() in dtb_set_property().
>   o Remove patch ("kexec: (bugfix) calc correct end address of memory ranges in device tree").
>
> Changes for v2 (July 26, 2016, 0m):
>
>   o Inline some small routines.
>   o Reformat some dbgprintf messages.
>   o Remove debug_brk from entry.S
>   o Change arm64_image_header.flags to uint64_t.
>   o Look in iomem then dt for mem info.
>   o Remove check_cpu_nodes.
>   o Remove purgatory printing.
>
> First submission v1 (July 20, 2016).
>
> -Geoff
>
> The following changes since commit 67488beb0a6ee8ad2c0b05f721a9e00041fab93a:
>
>   kexec-tools 2.0.13 (2016-08-08 12:26:44 +0200)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git for-merge-arm64-v6
>
> for you to fetch changes up to a9f1fafd7c248d33768177438742b90bc4338202:
>
>   arm64: Add support for binary image files (2016-09-21 11:04:03 -0700)
>
> ----------------------------------------------------------------
> Geoff Levand (2):
>       kexec: Add common device tree routines
>       arm64: Add arm64 kexec support
>
> Pratyush Anand (1):
>       arm64: Add support for binary image files
>
>  configure.ac                            |   3 +
>  kexec/Makefile                          |   5 +
>  kexec/arch/arm64/Makefile               |  40 +++
>  kexec/arch/arm64/crashdump-arm64.c      |  21 ++
>  kexec/arch/arm64/crashdump-arm64.h      |  12 +
>  kexec/arch/arm64/image-header.h         | 146 ++++++++
>  kexec/arch/arm64/include/arch/options.h |  39 ++
>  kexec/arch/arm64/kexec-arm64.c          | 615 ++++++++++++++++++++++++++++++++
>  kexec/arch/arm64/kexec-arm64.h          |  71 ++++
>  kexec/arch/arm64/kexec-elf-arm64.c      | 146 ++++++++
>  kexec/arch/arm64/kexec-image-arm64.c    |  80 +++++
>  kexec/dt-ops.c                          | 145 ++++++++
>  kexec/dt-ops.h                          |  13 +
>  kexec/kexec-syscall.h                   |   8 +-
>  purgatory/Makefile                      |   1 +
>  purgatory/arch/arm64/Makefile           |  18 +
>  purgatory/arch/arm64/entry.S            |  51 +++
>  purgatory/arch/arm64/purgatory-arm64.c  |  19 +
>  18 files changed, 1431 insertions(+), 2 deletions(-)
>  create mode 100644 kexec/arch/arm64/Makefile
>  create mode 100644 kexec/arch/arm64/crashdump-arm64.c
>  create mode 100644 kexec/arch/arm64/crashdump-arm64.h
>  create mode 100644 kexec/arch/arm64/image-header.h
>  create mode 100644 kexec/arch/arm64/include/arch/options.h
>  create mode 100644 kexec/arch/arm64/kexec-arm64.c
>  create mode 100644 kexec/arch/arm64/kexec-arm64.h
>  create mode 100644 kexec/arch/arm64/kexec-elf-arm64.c
>  create mode 100644 kexec/arch/arm64/kexec-image-arm64.c
>  create mode 100644 kexec/dt-ops.c
>  create mode 100644 kexec/dt-ops.h
>  create mode 100644 purgatory/arch/arm64/Makefile
>  create mode 100644 purgatory/arch/arm64/entry.S
>  create mode 100644 purgatory/arch/arm64/purgatory-arm64.c
>
