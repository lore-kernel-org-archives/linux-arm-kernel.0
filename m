From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 25 May 2011 10:28:55 -0700
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot
In-Reply-To: <1305899190-16732-1-git-send-email-marc.zyngier@arm.com>
References: <1305899190-16732-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DDD3C57.6020705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/11 06:46, Marc Zyngier wrote:
> Patch 7d30e8b38 (ARM: EXYNOS4: Add EXYNOS4 CPU initialization support)
> renamed the s5pv310 to exynos4, and also changed the value of
> EXYNOS4_PA_SYSRAM, which is used to release the secondary CPU from
> spinning in BL0. As a result, CPU1 can't be brought up anymore.
>
> This patch simply reverts EXYNOS4_PA_SYSRAM to its original value,
> which results in a working CPU1.
>
> Tested on an SMDK-v310.
>
> Cc: Kukjin Kim<kgene.kim@samsung.com>
> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> ---
>   arch/arm/mach-exynos4/include/mach/map.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
> index 6330b73..862967f 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -23,7 +23,7 @@
>
>   #include<plat/map-s5p.h>
>
> -#define EXYNOS4_PA_SYSRAM		0x02020000
> +#define EXYNOS4_PA_SYSRAM		0x02025000
>
Hi Marc,

Hmm...the value, 0x02020000 is correct on Exynos4210 now.

So can't apply this but I know, you're right on old version of 
Exynos4210...let's think again about this.

Maybe I missed its commit for changing when I submitted it...

>   #define EXYNOS4_PA_FIMC0		0x11800000
>   #define EXYNOS4_PA_FIMC1		0x11810000

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
