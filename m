From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 1 Feb 2012 14:53:39 +0900
Subject: [PATCH 8/9] ARM: EXYNOS: temporary add map definitions for uart
In-Reply-To: <1328024354-4277-9-git-send-email-kgene.kim@samsung.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-9-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAH9JG2VU-rLQ=fQT5Jx5kPcHSLOiEcTVdFaQjsWnxA=Yr6i0Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/map.h |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/include/mach/map.h
> b/arch/arm/mach-exynos/include/mach/map.h
> index f88acaf..300ed7e 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -167,9 +167,10 @@
>  #define S3C_PA_IIC5			EXYNOS4_PA_IIC(5)
>  #define S3C_PA_IIC6			EXYNOS4_PA_IIC(6)
>  #define S3C_PA_IIC7			EXYNOS4_PA_IIC(7)
> +
>  #define S3C_PA_RTC			EXYNOS4_PA_RTC
>  #define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
> -#define S3C_PA_UART			EXYNOS4_PA_UART
> +
>  #define S3C_PA_SPI0			EXYNOS4_PA_SPI0
>  #define S3C_PA_SPI1			EXYNOS4_PA_SPI1
>  #define S3C_PA_SPI2			EXYNOS4_PA_SPI2
> @@ -198,9 +199,17 @@
>
>  /* Compatibility UART */
>
> +#ifdef CONFIG_ARCH_EXYNOS4
> +#define S3C_PA_UART			EXYNOS4_PA_UART
> +#endif
> +
> +#ifdef CONFIG_ARCH_EXYNOS5
> +#define S3C_PA_UART			EXYNOS5_PA_UART
> +#endif
If it selects the both ARCH_EXYNOS4 and ARCH_EXYNOS5, how to handle
this one? I think it's time to clean up these macro magic.
> +
>  #define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
>
> -#define S5P_PA_UART(x)			(EXYNOS4_PA_UART + ((x) * S3C_UART_OFFSET))
> +#define S5P_PA_UART(x)			(S3C_PA_UART + ((x) * S3C_UART_OFFSET))
>  #define S5P_PA_UART0			S5P_PA_UART(0)
>  #define S5P_PA_UART1			S5P_PA_UART(1)
>  #define S5P_PA_UART2			S5P_PA_UART(2)
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
