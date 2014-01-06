From: luis.henriques@canonical.com (Luis Henriques)
Date: Mon, 6 Jan 2014 14:39:31 +0000
Subject: Possible arm64 patches for stable
In-Reply-To: <20131220172827.GZ31886@sirena.org.uk>
References: <20131220172827.GZ31886@sirena.org.uk>
Message-ID: <20140106143931.GD2776@hercules>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Dec 20, 2013 at 05:28:27PM +0000, Mark Brown wrote:
> Hi,
> 
> While reading the kernel logs for arm64 (as one does) I noticed a few
> patches that seemed like candidates for either LTS or LTSI.  I've also
> had a couple of others mentioned via other routes.  What do you think of
> these?

Thanks, I'm picking some of these for the 3.11 kernel as well.

> 
>   4ecf7ccb1973 arm64: spinlock: retry trylock operation if strex fails on free lock

Already in 3.11.

> This seems like a correctness fix for spinlocks, though since the
> callers should cope with failure it's arguably just an optimisation.
> 
>   53ae3acd4390 arm64: Only enable local interrupts after the CPU is marked online
>   82b2f495fba3 arm64: virt: ensure visibility of __boot_cpu_mode
>   845ad05ec31e arm64: Change kernel stack size to 16K
>   6db83cea1c97 arm64: fix possible invalid FPSIMD initialization state
>   7b22c03536a5 arm64: check for number of arguments in syscall_get/set_arguments()
>   df503ba7f653 arm64: dts: Reserve the memory used for secondary CPU release address

I'm picking the last 3 commits, as the other ones are already in 3.11.
   
> These all look like correctness fixes of one kind or another; the change
> to 16K stacks is poorly explained but it looks like it's fixing failures
> of some kind.
> 
>   f0dd718090ae arm64: Remove unused cpu_name ascii in arch/arm64/mm/proc.S

This seems to be the wrong SHA1.  I've picked f3a1d7d assuming that's what
you meant.

> A user was reporting that this caused build failures due to alignment
> issues with some of the debug options turned on.  I've not fully
> investigated yet, this might be a toolchain issue though given how
> simple the change is.
> 
>   0d651e4e65e9 clocksource: arch_timer: use virtual counters

This is already in 3.11.
 
> This is as mentioned in the changelog a correctness fix for avoiding
> clocks going backwards and has also been found to be required to avoid
> boot hangs with CONFIG_PROVE_RCU_DELAY enabled.
> 
> There were also a few others that aren't entirely -stable material but
> might be a fit for LTSI (and the above might be if not -stable in
> themselves):
> 
>   b5b6c9e9149d arm64: Avoid cache flushing in flush_dcache_page()
>   7249b79f6b4c arm64: Do not flush the D-cache for anonymous pages
>   4f00130b70e5 arm64: Use Normal NonCacheable memory for writecombine

I'm picking the last one only (the other 2 are already in 3.11).

> These look like simple, localised optimisations.
> 
> Thanks,
> Mark

Cheers,
--
Luis
