From: john.garry@huawei.com (John Garry)
Date: Fri, 20 Jul 2018 10:07:24 +0100
Subject: [PATCH 0/3] Hook up qspinlock for arm64
In-Reply-To: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
References: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
Message-ID: <96e05678-b67b-d097-0299-d96b846e6647@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/2018 12:00, Will Deacon wrote:
> Hi everybody,
>
> With my recent changes to the core qspinlock code, it now performs well
> enough on arm64 to replace our ticket-based approach.
>
> Testing welcome,
>

Hi Will,

JFYI, In the scenario we tested - which had a spinlock under high 
contention from many CPUs - we were see a big performance improvement.

I see this patchset is in linux-next, so assume it will be in 4.19

Cheers,
John

> Will
>
> --->8
>
> Will Deacon (3):
>   arm64: barrier: Implement smp_cond_load_relaxed
>   arm64: locking: Replace ticket lock implementation with qspinlock
>   arm64: kconfig: Ensure spinlock fastpaths are inlined if !PREEMPT
>
>  arch/arm64/Kconfig                      |  11 +++
>  arch/arm64/include/asm/Kbuild           |   1 +
>  arch/arm64/include/asm/barrier.h        |  13 ++++
>  arch/arm64/include/asm/spinlock.h       | 117 +-------------------------------
>  arch/arm64/include/asm/spinlock_types.h |  17 +----
>  5 files changed, 27 insertions(+), 132 deletions(-)
>
