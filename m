From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 16:45:02 +0100
Subject: [PATCH v2 19/20] arm64: atomic64_dec_if_positive: fix incorrect
 branch condition
In-Reply-To: <1437734531-10698-20-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-20-git-send-email-will.deacon@arm.com>
Message-ID: <20150724154501.GT3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:42:10AM +0100, Will Deacon wrote:
> If we attempt to atomic64_dec_if_positive on INT_MIN, we will underflow
> and incorrectly decide that the original parameter was positive.
> 
> This patches fixes the broken condition code so that we handle this
> corner case correctly.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
