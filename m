From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 16:42:18 +0100
Subject: [PATCH v2 17/20] arm64: atomics: prefetch the destination word
 for write prior to stxr
In-Reply-To: <1437734531-10698-18-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-18-git-send-email-will.deacon@arm.com>
Message-ID: <20150724154218.GR3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:42:08AM +0100, Will Deacon wrote:
> The cost of changing a cacheline from shared to exclusive state can be
> significant, especially when this is triggered by an exclusive store,
> since it may result in having to retry the transaction.
> 
> This patch makes use of prfm to prefetch cachelines for write prior to
> ldxr/stxr loops when using the ll/sc atomic routines.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
