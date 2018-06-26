From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jun 2018 10:14:49 +0100
Subject: [RFC v2 0/4] arm: Moving thread_info into task_struct
In-Reply-To: <20180618153053.186224-1-zsm@chromium.org>
References: <20180618153053.186224-1-zsm@chromium.org>
Message-ID: <20180626091449.GE17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 08:30:49AM -0700, Zubin Mithra wrote:
> These are a set of preparatory patches for moving the thread_info
> into task_struct for ARM. The patches that perform that actual move
> are not implemented yet.

You don't explain why this is desirable or even wanted in your covering
message.  You need to do that rather than expecting that everyone knows
why you want these changes.

> These patches have only been tested on QEMU using the following boards.
> - versatilepb
> - vexpress-a9
> 
> [v2 changes]
> - Add a patch that stores thread_info in sp^
> 
> Zubin Mithra (4):
>   arm: Store address of thread_info in sp^
>   arm: factor out current_stack_pointer
>   arm: make cpu a percpu variable
>   arm: add refcounting for task stacks
> 
>  arch/arm/include/asm/assembler.h     | 27 ++++++++++++++++++++++-----
>  arch/arm/include/asm/percpu.h        |  2 ++
>  arch/arm/include/asm/smp.h           | 11 ++++++++++-
>  arch/arm/include/asm/stack_pointer.h |  9 +++++++++
>  arch/arm/include/asm/switch_to.h     | 11 +++++++++++
>  arch/arm/include/asm/thread_info.h   | 19 ++++++++++++-------
>  arch/arm/kernel/entry-armv.S         |  5 ++++-
>  arch/arm/kernel/entry-common.S       |  2 ++
>  arch/arm/kernel/head-common.S        |  2 ++
>  arch/arm/kernel/head.S               |  1 +
>  arch/arm/kernel/process.c            | 21 +++++++++++++++------
>  arch/arm/kernel/return_address.c     |  1 +
>  arch/arm/kernel/setup.c              |  2 +-
>  arch/arm/kernel/smp.c                | 13 +++++++++++--
>  arch/arm/kernel/stacktrace.c         |  8 ++++++++
>  arch/arm/kernel/topology.c           |  2 ++
>  arch/arm/kernel/traps.c              | 13 +++++++++++--
>  arch/arm/kernel/unwind.c             |  1 +
>  18 files changed, 125 insertions(+), 25 deletions(-)
>  create mode 100644 arch/arm/include/asm/stack_pointer.h
> 
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
