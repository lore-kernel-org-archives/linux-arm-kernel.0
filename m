From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jun 2018 16:44:26 +0100
Subject: [PATCH] arm64: kpti: Use early_param for kpti= command-line option
In-Reply-To: <20180620154032.kwhvuwibustjqmwz@armageddon.cambridge.arm.com>
References: <1529508227-24331-1-git-send-email-will.deacon@arm.com>
 <20180620154032.kwhvuwibustjqmwz@armageddon.cambridge.arm.com>
Message-ID: <20180620154426.GC27776@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 04:40:32PM +0100, Catalin Marinas wrote:
> On Wed, Jun 20, 2018 at 04:23:47PM +0100, Will Deacon wrote:
> > We inspect __kpti_forced early on as part of the cpufeature enable
> > callback which remaps the swapper page table using non-global entries.
> > 
> > Ensure that __kpti_forced has been updated to reflect the kpti=
> > command-line option before we start using it.
> > 
> > Reported-by: Wei Xu <xuwei5@hisilicon.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Does it need a fixes tag?
> 
> Fixes: ea1e3de85e94 ("arm64: entry: Add fake CPU feature for unmapping the kernel at EL0")

Perhaps, but really this is just a performance optimisation for the kpti=off
case where we don't actually need to put the nG mappings down.

Will
