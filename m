From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Jun 2018 16:40:32 +0100
Subject: [PATCH] arm64: kpti: Use early_param for kpti= command-line option
In-Reply-To: <1529508227-24331-1-git-send-email-will.deacon@arm.com>
References: <1529508227-24331-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180620154032.kwhvuwibustjqmwz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 04:23:47PM +0100, Will Deacon wrote:
> We inspect __kpti_forced early on as part of the cpufeature enable
> callback which remaps the swapper page table using non-global entries.
> 
> Ensure that __kpti_forced has been updated to reflect the kpti=
> command-line option before we start using it.
> 
> Reported-by: Wei Xu <xuwei5@hisilicon.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Does it need a fixes tag?

Fixes: ea1e3de85e94 ("arm64: entry: Add fake CPU feature for unmapping the kernel at EL0")

-- 
Catalin
