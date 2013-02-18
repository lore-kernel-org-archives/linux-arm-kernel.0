From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Feb 2013 20:47:23 +0900
Subject: [PATCH 0/4] ARM: shmobile: kzm9g reference SMP and cleanup
In-Reply-To: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
References: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130218114723.GA23092@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 10:00:56PM +0900, Simon Horman wrote:
> Hi,
> 
> this series tweaks the defconfig to allow SMP kzm9g reference
> to successfully boot. The series also contains a number of cleanups.
> 
> The series is based on the boards-kzm9g-reference branch
> in the renesas tree.

Magnus asked me to detail the changes that I needed to make to make SMP
kzm9g reference work. I can do so in two words: disable CONFIG_PREEMPT.

The first patch in this series makes that changes.

The 4th patch in the series adds SMP ops to the sh73a0 DT_MACHINE_START
which adds SMP support when booting an sh73a0 based board using DT without
a board file compiled into the kernel. This has been tested with the kzm9g
board.

I consider the remaining patches clean-ups.

> Simon Horman (5):
>   ARM: shmobile: kzm9g: defconfig: do not enable PREEMPT
>   ARM: shmobile: kzm9g: Remove warning about SMP
>   ARM: shmobile: sh73a0: Remove sh73a0_init_irq_dt()
>   ARM: shmobile: sh73a0: Add smp ops to DT_MACHINE_START
>   ARM: shmobile: kzm9g: Trim reference DT_MACHINE_START
> 
>  arch/arm/configs/kzm9g_defconfig               |    1 -
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |   19 ++-----------------
>  arch/arm/mach-shmobile/intc-sh73a0.c           |    8 --------
>  arch/arm/mach-shmobile/setup-sh73a0.c          |    4 +++-
>  4 files changed, 5 insertions(+), 27 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
