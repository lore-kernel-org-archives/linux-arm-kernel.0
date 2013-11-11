From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Nov 2013 10:08:10 +0100
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
Message-ID: <20131111090810.GI14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

On Wed, Oct 09, 2013 at 06:13:13PM +0100, Will Deacon wrote:
> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
> 
>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/prefetch
> 
> for you to fetch changes up to d779c07dd72098a7416d907494f958213b7726f3:
> 
>   ARM: bitops: prefetch the destination word for write prior to strex (2013-09-30 16:42:56 +0100)
> 
> ----------------------------------------------------------------
> Will Deacon (6):
>       ARM: prefetch: remove redundant "cc" clobber
>       ARM: smp_on_up: move inline asm ALT_SMP patching macro out of spinlock.h
>       ARM: prefetch: add support for prefetchw using pldw on SMP ARMv7+ CPUs
>       ARM: locks: prefetch the destination word for write prior to strex
>       ARM: atomics: prefetch the destination word for write prior to strex
>       ARM: bitops: prefetch the destination word for write prior to strex
Hello Will,

it seems the last patch breaks on efm32:

arch/arm/lib/changebit.S: Assembler messages:
arch/arm/lib/changebit.S:15: Error: architectural extension `mp' is not allowed for the current base architecture

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
