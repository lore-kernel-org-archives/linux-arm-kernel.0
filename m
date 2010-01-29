From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Jan 2010 11:08:32 +0000
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resumefunctions
In-Reply-To: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
Message-ID: <1264763312.4242.47.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-28 at 22:59 +0000, Daniel Walker wrote:
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index cb8fc65..c746878 100644
[...]
> +static inline void l2x0_flush_all(void)
> +{
> +       /* clean and invalidate all ways */
> +       sync_writel(0xff, L2X0_CLEAN_INV_WAY, 0xff);
> +       cache_sync();
> +}

Do we need any for of locking around this code (as we do for
l2x0_inv_all) or races are not possible during suspend?

-- 
Catalin
