From: panand@redhat.com (Pratyush Anand)
Date: Wed, 24 Aug 2016 12:56:22 +0530
Subject: [PATCH 0/5] ARM64: Uprobe support added
In-Reply-To: <cover.1470114993.git.panand@redhat.com>
References: <cover.1470114993.git.panand@redhat.com>
Message-ID: <20160824072622.GB24311@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will/Catalin,

Do you have any specific comment for this patch set?

~Pratyush

[1] https://lkml.org/lkml/2016/8/22/69

On 02/08/2016:11:00:04 AM, Pratyush Anand wrote:
> ARM64 kprobe support is lying in torvalds/linux.git:master now. Therefore
> sending my uprobe patches which were dependent on decode-insn code of kprobe
> patches.
> 
> Unit tests for following have been done so far and they have been found
> working.
>      1. Step-able instructions, like sub, ldr, add etc.
>      2. Simulation-able like ret, cbnz, cbz etc.
>      3. uretprobe
>      4. Reject-able instructions like sev, wfe etc.
>      5. trapped and abort xol path
>      6. probe at unaligned user address.
>      7. longjump test cases
>  
> Currently it does not support aarch32 instruction probing.
> 
> RFC patches were sent long back, and all review comments for RFCs have been
> incorporated. RFCs were here: https://lwn.net/Articles/648514/
> 
> Pratyush Anand (5):
>   arm64: kprobe: protect/rename few definitions to be reused by uprobe
>   arm64: kgdb_step_brk_fn: ignore other's exception
>   arm64: Handle TRAP_HWBRKPT for user mode as well
>   arm64: Handle TRAP_BRKPT for user mode as well
>   arm64: Add uprobe support
> 
>  arch/arm64/Kconfig                      |   3 +
>  arch/arm64/include/asm/debug-monitors.h |   3 +
>  arch/arm64/include/asm/probes.h         |  23 ++--
>  arch/arm64/include/asm/ptrace.h         |   8 ++
>  arch/arm64/include/asm/thread_info.h    |   5 +-
>  arch/arm64/include/asm/uprobes.h        |  37 ++++++
>  arch/arm64/kernel/debug-monitors.c      |  40 +++---
>  arch/arm64/kernel/entry.S               |   6 +-
>  arch/arm64/kernel/kgdb.c                |   3 +
>  arch/arm64/kernel/probes/Makefile       |   2 +
>  arch/arm64/kernel/probes/decode-insn.c  |  31 ++---
>  arch/arm64/kernel/probes/decode-insn.h  |   8 +-
>  arch/arm64/kernel/probes/kprobes.c      |  36 ++---
>  arch/arm64/kernel/probes/uprobes.c      | 227 ++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/signal.c              |   4 +-
>  arch/arm64/mm/flush.c                   |   6 +
>  16 files changed, 378 insertions(+), 64 deletions(-)
>  create mode 100644 arch/arm64/include/asm/uprobes.h
>  create mode 100644 arch/arm64/kernel/probes/uprobes.c
> 
> -- 
> 2.5.5
