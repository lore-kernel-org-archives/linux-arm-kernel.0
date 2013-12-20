From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Dec 2013 14:10:02 +0000
Subject: [PATCH] arm64: cmpxchg: update macros to prevent warnings
In-Reply-To: <1387543334-14036-1-git-send-email-broonie@kernel.org>
References: <1387543334-14036-1-git-send-email-broonie@kernel.org>
Message-ID: <20131220141000.GA11954@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 12:42:14PM +0000, Mark Brown wrote:
> From: Mark Hambleton <mahamble@broadcom.com>
> 
> Make sure the value we are going to return is referenced in order to
> avoid warnings from newer GCCs such as:
> 
> arch/arm64/include/asm/cmpxchg.h:162:3: warning: value computed is not used [-Wunused-value]
>   ((__typeof__(*(ptr)))__cmpxchg_mb((ptr),   \
>    ^
> net/netfilter/nf_conntrack_core.c:674:2: note: in expansion of macro ???cmpxchg???
>   cmpxchg(&nf_conntrack_hash_rnd, 0, rand);
> 
> [Modified to use the current underlying implementation as current
> mainline for both cmpxchg() and cmpxchg_local() does -- broonie]
> 
> Signed-off-by: Mark Hambleton <mahamble@broadcom.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>

I merged the previous one (should be in -next as of last night), I guess
it's the same since the patch doesn't have a version number. But I
wonder whether uses of cmpxchg without checking the return value are
sane.

-- 
Catalin
