From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 15 Jul 2013 15:01:42 +0530
Subject: [PATCH] cpufreq: s3c24xx: fix typo "ARM_S3C24XX"
In-Reply-To: <1373803339.1370.18.camel@x61.thuisdomein>
References: <1373803339.1370.18.camel@x61.thuisdomein>
Message-ID: <CAKohpok1xvsVrssYrNJJZ2GTLJZVnY8SrCzNx+VdXbiMjL6uLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2013 17:32, Paul Bolle <pebolle@tiscali.nl> wrote:
> Kconfig symbol S3C24XX_PLL depends on ARM_S3C24XX. But that symbol
> doesn't exist. Commit f023f8dd59bf ("cpufreq: s3c24xx: move cpufreq
> driver to drivers/cpufreq"), which added this typo, makes clear that
> ARM_S3C24XX_CPUFREQ was intended here.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested!
>
>  arch/arm/mach-s3c24xx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 6d9252e..7791ac7 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -208,7 +208,7 @@ config S3C24XX_GPIO_EXTRA128
>
>  config S3C24XX_PLL
>         bool "Support CPUfreq changing of PLL frequency (EXPERIMENTAL)"
> -       depends on ARM_S3C24XX
> +       depends on ARM_S3C24XX_CPUFREQ
>         help
>           Compile in support for changing the PLL frequency from the
>           S3C24XX series CPUfreq driver. The PLL takes time to settle

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: I saw you taking other s3c patch directly. Mind taking this
one too?
