From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 20 Jul 2016 13:30:37 +0900
Subject: [PATCH v1 0/4] arm64 kexec-tools patches
In-Reply-To: <cover.1468970114.git.geoff@infradead.org>
References: <cover.1468970114.git.geoff@infradead.org>
Message-ID: <20160720043035.GJ20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 11:28:13PM +0000, Geoff Levand wrote:
> This series adds the core support for kexec re-boot on ARM64.

Just in case. This patchset doesn't contain kdump-related patches.
Since my kdump kernel patches are still under review, I'd like
to post my kexec-tools patches separately as well.

Thanks,
-Takahiro AKASHI

> Linux kernel support for kexec reboot [1] has been merged to the ARM64
> for-next/core branch with the expectation that it will be included in the v4.8
> stable kernel release.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html
> 
> - Geoff
> 
> The following changes since commit 8d614008609f6ad5d09263767ebc771e06a173f0:
> 
>   arm: use zImage size from header (2016-07-15 13:12:28 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git for-merge-arm64-v1
> 
> for you to fetch changes up to 5b7aa684a9f2cf26a71b78f82d279f1d93fd644a:
> 
>   arm64: Add support for binary image files (2016-07-19 16:08:38 -0700)
> 
> ----------------------------------------------------------------
> AKASHI Takahiro (1):
>       kexec: (bugfix) calc correct end address of memory ranges in device tree
> 
> Geoff Levand (2):
>       kexec: Add common device tree routines
>       arm64: Add arm64 kexec support
> 
> Pratyush Anand (1):
>       arm64: Add support for binary image files
> 
>  configure.ac                            |   3 +
>  kexec/Makefile                          |   5 +
>  kexec/arch/arm64/Makefile               |  40 ++
>  kexec/arch/arm64/crashdump-arm64.c      |  21 +
>  kexec/arch/arm64/crashdump-arm64.h      |  12 +
>  kexec/arch/arm64/image-header.h         |  94 +++
>  kexec/arch/arm64/include/arch/options.h |  43 ++
>  kexec/arch/arm64/kexec-arm64.c          | 995 ++++++++++++++++++++++++++++++++
>  kexec/arch/arm64/kexec-arm64.h          |  58 ++
>  kexec/arch/arm64/kexec-elf-arm64.c      | 130 +++++
>  kexec/arch/arm64/kexec-image-arm64.c    |  63 ++
>  kexec/dt-ops.c                          | 139 +++++
>  kexec/dt-ops.h                          |  13 +
>  kexec/fs2dt.c                           |   5 +-
>  kexec/kexec-syscall.h                   |   8 +-
>  purgatory/Makefile                      |   1 +
>  purgatory/arch/arm64/Makefile           |  18 +
>  purgatory/arch/arm64/entry.S            |  59 ++
>  purgatory/arch/arm64/purgatory-arm64.c  |  35 ++
>  19 files changed, 1738 insertions(+), 4 deletions(-)
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
> -- 
> 2.5.0
> 
