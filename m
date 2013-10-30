From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 30 Oct 2013 08:24:35 -0700
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
Message-ID: <527124B3.9090305@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will et al.,

On 10/09/2013 10:13 AM, Will Deacon wrote:
> Hi Russell,
>
> Please pull the following patches for 3.13. They add support for the pldw
> instruction (prefetch with intent to modify) in ARMv7 SMP cores, which is
> then used to gain a measurable performance boost for particular atomic
> sequences.

Looks like the pldw changes require binutils >= 2.21.  Might be worth 
considering a patch to update Documentation/Changes?


- Paul

>
> Cheers,
>
> Will
>
> --->8
>
> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
>
>    Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
>
> are available in the git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/prefetch
>
> for you to fetch changes up to d779c07dd72098a7416d907494f958213b7726f3:
>
>    ARM: bitops: prefetch the destination word for write prior to strex (2013-09-30 16:42:56 +0100)
>
> ----------------------------------------------------------------
> Will Deacon (6):
>        ARM: prefetch: remove redundant "cc" clobber
>        ARM: smp_on_up: move inline asm ALT_SMP patching macro out of spinlock.h
>        ARM: prefetch: add support for prefetchw using pldw on SMP ARMv7+ CPUs
>        ARM: locks: prefetch the destination word for write prior to strex
>        ARM: atomics: prefetch the destination word for write prior to strex
>        ARM: bitops: prefetch the destination word for write prior to strex
>
>   arch/arm/include/asm/atomic.h         |  7 +++++++
>   arch/arm/include/asm/processor.h      | 33 +++++++++++++++++++++++++--------
>   arch/arm/include/asm/spinlock.h       | 28 ++++++++++++++--------------
>   arch/arm/include/asm/spinlock_types.h |  2 +-
>   arch/arm/include/asm/unified.h        |  4 ++++
>   arch/arm/lib/bitops.h                 |  5 +++++
>   6 files changed, 56 insertions(+), 23 deletions(-)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
