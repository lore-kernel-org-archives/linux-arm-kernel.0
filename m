From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 09:07:28 +0000
Subject: [PATCH] ARM: S5PV310: Set bit 22 in the PL310 (cache
	controller) AuxCtlr register
In-Reply-To: <1289976931-9759-1-git-send-email-kgene.kim@samsung.com>
References: <1289976931-9759-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1289984848.2351.2.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-17 at 06:55 +0000, Kukjin Kim wrote:
> --- a/arch/arm/mach-s5pv310/cpu.c
> +++ b/arch/arm/mach-s5pv310/cpu.c
> @@ -168,7 +168,7 @@ static int __init s5pv310_l2x0_cache_init(void)
>         __raw_writel(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN,
>                      S5P_VA_L2CC + L2X0_POWER_CTRL);
> 
> -       l2x0_init(S5P_VA_L2CC, 0x7C070001, 0xC200ffff);
> +       l2x0_init(S5P_VA_L2CC, 0x7C470001, 0xC200ffff);

The patch is fine.

But I think we should also set this bit in the cache-l2x0.c file if
PL310. That's such a fundamental issue and it's easy to miss in the
platform code.

-- 
Catalin
