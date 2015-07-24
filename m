From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 12:38:21 +0100
Subject: [PATCH v2 07/20] arm64: introduce CONFIG_ARM64_LSE_ATOMICS as
 fallback to ll/sc atomics
In-Reply-To: <1437734531-10698-8-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-8-git-send-email-will.deacon@arm.com>
Message-ID: <20150724113821.GH3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:58AM +0100, Will Deacon wrote:
> In order to patch in the new atomic instructions at runtime, we need to
> generate wrappers around the out-of-line exclusive load/store atomics.
> 
> This patch adds a new Kconfig option, CONFIG_ARM64_LSE_ATOMICS. which
> causes our atomic functions to branch to the out-of-line ll/sc
> implementations. To avoid the register spill overhead of the PCS, the
> out-of-line functions are compiled with specific compiler flags to
> force out-of-line save/restore of any registers that are usually
> caller-saved.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Slightly easier to read now ;).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
