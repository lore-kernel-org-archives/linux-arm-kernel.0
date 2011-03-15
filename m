From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Mar 2011 21:55:20 +0900
Subject: [PATCH v2] ARM: EXYNOS4: add a placeholder for board specific
	interrupts
In-Reply-To: <1300086405-9895-1-git-send-email-m.szyprowski@samsung.com>
References: <1300086405-9895-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <011301cbe310$41381f10$c3a85d30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch adds a placeholder for board specific interrupts on S5PC210
> platform.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/include/mach/irqs.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-
> exynos4/include/mach/irqs.h
> index 5d03730..cc2186d 100644
> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
> @@ -154,7 +154,11 @@
>  #define IRQ_GPIO2_NR_GROUPS	9
>  #define IRQ_GPIO_END		(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
> 
> +/* optional board specific irqs */
> +#define IRQ_BOARD_START		IRQ_GPIO_END
> +#define IRQ_NR_BOARD		16
> +
>  /* Set the default NR_IRQS */
> -#define NR_IRQS			(IRQ_GPIO_END)
> +#define NR_IRQS			(IRQ_GPIO_END + IRQ_NR_BOARD)
> 
>  #endif /* __ASM_ARCH_IRQS_H */
> --
> 1.7.1.569.g6f426

I have no idea that we need specific interrupt on EXYNOS4 now.
As you know, this can affect all machines of EXYNOS4 SoC even though there
is EXYNOS4210 now.

If required, we need something like SAMSUNG_GPIO_EXTRA for compatibility.
Anyway need more discussion on this :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
