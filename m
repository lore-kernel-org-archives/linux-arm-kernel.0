From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Mon, 18 Jan 2016 21:18:00 +0800
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <569CE608.4060904@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yury

On 2016/1/15 1:22, Yury Norov wrote:
[...]
> Bamvor Jian Zhang (1):
>    arm64: compat: change config dependences to aarch32
There is no this patch in this series. 05/21 is missing:)

Regards

Bamvor

> Philipp Tomsich (1):
>    arm64:ilp32: add vdso-ilp32 and use for signal return
>
> Yury Norov (13):
>    arm64: ilp32: add documentation on the ILP32 ABI for ARM64
>    thread: move thread bits accessors to separated file
>    arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
>    arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
>    arm64: introduce binfmt_elf32.c
>    arm64: ilp32: introduce binfmt_ilp32.c
>    arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
>    arm64: signal: wrap struct ucontext, fp and lr with struct sigframe
>    arm64: signal: share lp64 signal routines to ilp32
>    arm64: signal32: move ilp32 and aarch32 common code to separated file
>    arm64: ilp32: introduce ilp32-specific handlers for sigframe
>    all: s390: make compat wrappers the generic solution
>    arm64: ilp32: wrap syscalls to remove top 32-bit vulnerability
>
>   Documentation/arm64/ilp32.txt                 |  13 ++
>   arch/Kconfig                                  |   4 +
>   arch/arm64/Kconfig                            |  17 +-
>   arch/arm64/Makefile                           |   5 +
>   arch/arm64/include/asm/compat.h               |  19 +-
>   arch/arm64/include/asm/compat_wrapper.h       |  14 ++
>   arch/arm64/include/asm/elf.h                  |  32 +--
>   arch/arm64/include/asm/fpsimd.h               |   2 +-
>   arch/arm64/include/asm/hwcap.h                |   6 +-
>   arch/arm64/include/asm/is_compat.h            |  84 ++++++++
>   arch/arm64/include/asm/memory.h               |   3 +-
>   arch/arm64/include/asm/processor.h            |  11 +-
>   arch/arm64/include/asm/ptrace.h               |   2 +-
>   arch/arm64/include/asm/signal32.h             |   6 +-
>   arch/arm64/include/asm/signal32_common.h      |  25 +++
>   arch/arm64/include/asm/signal_common.h        |  39 ++++
>   arch/arm64/include/asm/signal_ilp32.h         |  34 ++++
>   arch/arm64/include/asm/thread_info.h          |   3 +-
>   arch/arm64/include/asm/unistd.h               |  11 +-
>   arch/arm64/include/asm/unistd32.h             |   2 +-
>   arch/arm64/include/asm/vdso.h                 |   6 +
>   arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
>   arch/arm64/kernel/Makefile                    |  12 +-
>   arch/arm64/kernel/asm-offsets.c               |   2 +-
>   arch/arm64/kernel/binfmt_elf32.c              |  33 ++++
>   arch/arm64/kernel/binfmt_ilp32.c              |  91 +++++++++
>   arch/arm64/kernel/cpufeature.c                |   8 +-
>   arch/arm64/kernel/cpuinfo.c                   |   4 +-
>   arch/arm64/kernel/entry.S                     |  18 +-
>   arch/arm64/kernel/entry_ilp32.S               |  23 +++
>   arch/arm64/kernel/head.S                      |   2 +-
>   arch/arm64/kernel/hw_breakpoint.c             |  10 +-
>   arch/arm64/kernel/perf_regs.c                 |   2 +-
>   arch/arm64/kernel/process.c                   |   5 +-
>   arch/arm64/kernel/ptrace.c                    |  65 ++++++-
>   arch/arm64/kernel/signal.c                    |  47 +++--
>   arch/arm64/kernel/signal32.c                  |  85 --------
>   arch/arm64/kernel/signal32_common.c           | 115 +++++++++++
>   arch/arm64/kernel/signal_ilp32.c              | 128 ++++++++++++
>   arch/arm64/kernel/sys32.c                     |   1 +
>   arch/arm64/kernel/sys_ilp32.c                 |  69 +++++++
>   arch/arm64/kernel/traps.c                     |   5 +-
>   arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
>   arch/arm64/kernel/vdso-ilp32/Makefile         |  72 +++++++
>   arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 ++++
>   arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 +++++++++
>   arch/arm64/kernel/vdso.c                      |  65 +++++--
>   arch/s390/Kconfig                             |   1 +
>   arch/s390/include/asm/compat_wrapper.h        |  25 +++
>   arch/s390/kernel/Makefile                     |   2 +-
>   arch/s390/kernel/compat_linux.c               |   6 +
>   arch/s390/kernel/compat_wrapper.c             | 179 -----------------
>   drivers/clocksource/arm_arch_timer.c          |   2 +-
>   include/linux/compat_wrapper.h                | 270 ++++++++++++++++++++++++++
>   include/linux/ptrace.h                        |   6 +
>   include/linux/thread_bits.h                   |  55 ++++++
>   include/linux/thread_info.h                   |  44 +----
>   include/uapi/asm-generic/unistd.h             | 224 ++++++++++-----------
>   kernel/Makefile                               |   1 +
>   kernel/compat_wrapper.c                       | 167 ++++++++++++++++
>   kernel/ptrace.c                               |  10 +-
>   61 files changed, 1777 insertions(+), 554 deletions(-)
>   create mode 100644 Documentation/arm64/ilp32.txt
>   create mode 100644 arch/arm64/include/asm/compat_wrapper.h
>   create mode 100644 arch/arm64/include/asm/is_compat.h
>   create mode 100644 arch/arm64/include/asm/signal32_common.h
>   create mode 100644 arch/arm64/include/asm/signal_common.h
>   create mode 100644 arch/arm64/include/asm/signal_ilp32.h
>   create mode 100644 arch/arm64/kernel/binfmt_elf32.c
>   create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
>   create mode 100644 arch/arm64/kernel/entry_ilp32.S
>   create mode 100644 arch/arm64/kernel/signal32_common.c
>   create mode 100644 arch/arm64/kernel/signal_ilp32.c
>   create mode 100644 arch/arm64/kernel/sys_ilp32.c
>   create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
>   create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
>   create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
>   create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
>   create mode 100644 arch/s390/include/asm/compat_wrapper.h
>   delete mode 100644 arch/s390/kernel/compat_wrapper.c
>   create mode 100644 include/linux/compat_wrapper.h
>   create mode 100644 include/linux/thread_bits.h
>   create mode 100644 kernel/compat_wrapper.c
>
