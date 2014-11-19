From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Nov 2014 03:02:41 +0100
Subject: [PATCH 1/8] ARM: convert printk(KERN_* to pr_*
In-Reply-To: <E1XqSvh-0002EF-3Y@rmk-PC.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
 <E1XqSvh-0002EF-3Y@rmk-PC.arm.linux.org.uk>
Message-ID: <20141119020241.GG16103@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 08:29:45PM +0000, Russell King wrote:
> Convert many (but not all) printk(KERN_* to pr_* to simplify the code.
> We take the opportunity to join some printk lines together so we don't
> split the message across several lines, and we also add a few levels
> to some messages which were previously missing them.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/common/sa1111.c        | 13 ++++++-------
>  arch/arm/kernel/atags_compat.c  |  6 ++----
>  arch/arm/kernel/atags_parse.c   |  5 ++---
>  arch/arm/kernel/atags_proc.c    |  4 ++--
>  arch/arm/kernel/bios32.c        |  2 +-
>  arch/arm/kernel/dma-isa.c       |  4 ++--
>  arch/arm/kernel/dma.c           | 26 +++++++++++--------------
>  arch/arm/kernel/etm.c           | 12 ++++++------
>  arch/arm/kernel/fiq.c           |  2 +-
>  arch/arm/kernel/irq.c           |  2 +-
>  arch/arm/kernel/machine_kexec.c |  6 +++---
>  arch/arm/kernel/module.c        |  2 +-
>  arch/arm/kernel/smp.c           | 16 ++++++++--------
>  arch/arm/kernel/smp_twd.c       |  4 ++--
>  arch/arm/kernel/swp_emulate.c   |  2 +-
>  arch/arm/kernel/thumbee.c       |  2 +-
>  arch/arm/kernel/topology.c      |  4 ++--
>  arch/arm/kernel/traps.c         | 42 ++++++++++++++++++++---------------------
>  arch/arm/kernel/xscale-cp0.c    |  7 +++----
>  arch/arm/mm/alignment.c         | 10 +++++-----
>  arch/arm/mm/cache-feroceon-l2.c |  6 +++---

Hi Russell

I booted on Kirkwood, which uses feroceon. The feroceon Info messages
are in the log as you would expect. Given this sort of mechanical
transformation, i don't real see how it could go wrong. But anyway:

Tested-by: Andrew Lunn <andrew@lunn.ch>

	   Andrew
