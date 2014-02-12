From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 12 Feb 2014 09:47:17 +0100
Subject: [PATCH v6 0/3] perf: AARCH64 arch support
In-Reply-To: <1391451509-31265-1-git-send-email-jean.pihet@linaro.org>
References: <1391451509-31265-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <CAFrcx1mBWnO7mivQtGY1qLfd=KwV4ehyZoq0tV7buMiWKrTqrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Ping on the series. Is this OK for inclusion?

Regards,
Jean

On 3 February 2014 19:18, Jean Pihet <jean.pihet@linaro.org> wrote:
> Add AARCH64 specific support. This includes the following:
> - AARCH64 perf registers definition and hooks,
> - compat mode registers use, i.e. profiling a 32-bit binary on
>    a 64-bit system,
> - unwinding using the dwarf information from the .debug_frame
>    section of the ELF binary,
> - unwinding using the frame pointer information; in 64-bit and
>    compat modes.
>
> Notes:
> - the tools/perf change is submitted separately on LKML,
> - support for unwinding using the dwarf information in compat
> mode requires some changes to the libunwind code. Those changes
> have been submitted on the libunwind ML and are in discussion.
>
> Tested on ARMv7, ARMv8 and x86_64 platforms. The compat mode has been
> tested on ARMv8 using statically built 32-bit binaries.
>
>
> Jean Pihet (3):
>   ARM64: perf: add support for perf registers API
>   ARM64: perf: add support for frame pointer unwinding in compat mode
>   ARM64: perf: support dwarf unwinding in compat mode
>
>  arch/arm64/Kconfig                      |  2 +
>  arch/arm64/include/asm/compat.h         |  2 +-
>  arch/arm64/include/asm/ptrace.h         |  3 +-
>  arch/arm64/include/uapi/asm/Kbuild      |  1 +
>  arch/arm64/include/uapi/asm/perf_regs.h | 40 ++++++++++++++++++
>  arch/arm64/kernel/Makefile              |  1 +
>  arch/arm64/kernel/perf_event.c          | 75 +++++++++++++++++++++++++++++----
>  arch/arm64/kernel/perf_regs.c           | 44 +++++++++++++++++++
>  8 files changed, 158 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm64/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/arm64/kernel/perf_regs.c
>
> --
> 1.7.11.7
>
