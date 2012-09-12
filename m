From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Wed, 12 Sep 2012 22:00:54 +0530
Subject: Fwd: [PATCH v9 07/13] ARM: SoC: convert ux500 to SoC descriptor
In-Reply-To: <CAE2-_9o5gEpEddGLvRRA=pe=vroTnBXmGmoBO1Ojos-hOJXQAQ@mail.gmail.com>
References: <1347461906-13527-1-git-send-email-arnd@arndb.de>
 <1347461906-13527-8-git-send-email-arnd@arndb.de>
 <CAE2-_9o5gEpEddGLvRRA=pe=vroTnBXmGmoBO1Ojos-hOJXQAQ@mail.gmail.com>
Message-ID: <20120912163053.GA10988@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> 
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Convert ux500 platforms to use the SoC descriptor to provide
> their SMP and CPU hotplug operations.
> 
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ux500/board-mop500.c       |    4 ++++
>  arch/arm/mach-ux500/hotplug.c            |   36 ++++++++----------------------
>  arch/arm/mach-ux500/include/mach/setup.h |    3 +++
>  arch/arm/mach-ux500/platsmp.c            |   18 +++++++++++----
>  4 files changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index a534d88..1c6f74b 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -694,6 +694,7 @@ static void __init hrefv60_init_machine(void)
>  MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
>         /* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
>         .atag_offset    = 0x100,
> +       .smp            = smp_ops(ux500_smp_ops),
>         .map_io         = u8500_map_io,
>         .init_irq       = ux500_init_irq,
>         /* we re-use nomadik timer here */
> @@ -705,6 +706,7 @@ MACHINE_END

This looks like mips way doing smp operations.

I have not tested the patch series, will do later.

Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

/srinidhi
