From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 31 Aug 2012 09:29:42 +0530
Subject: [PATCH 4/6] ARM: Exynos4: Add OF compatibility lookups for
 Exynos4 i2c adapters
In-Reply-To: <1346311903-15920-5-git-send-email-t.figa@samsung.com>
References: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
 <1346311903-15920-5-git-send-email-t.figa@samsung.com>
Message-ID: <CAJuYYwT+diyXX0O2WOJ3=yFMJwEXLbb30rmcYfbomjaFEQmOuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 August 2012 13:01, Tomasz Figa <t.figa@samsung.com> wrote:
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/mach-exynos4-dt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
> index 8dad4ec..0391c84 100644
> --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> @@ -61,6 +61,22 @@ static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
>                                 "exynos4210-spi.1", NULL),
>         OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI2,
>                                 "exynos4210-spi.2", NULL),
> +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(0),
> +                               "s3c2440-i2c.0", NULL),

i2c0 lookup information is already in this list. So the above line
should not be included in this patch.

> +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(1),
> +                               "s3c2440-i2c.1", NULL),
> +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(2),
> +                               "s3c2440-i2c.2", NULL),
> +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(3),
> +                               "s3c2440-i2c.3", NULL),
> +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(4),
> +                               "s3c2440-i2c.4", NULL),
> +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(5),
> +                               "s3c2440-i2c.5", NULL),
> +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(6),
> +                               "s3c2440-i2c.6", NULL),
> +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(7),
> +                               "s3c2440-i2c.7", NULL),
>         OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA0, "dma-pl330.0", NULL),
>         OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA1, "dma-pl330.1", NULL),
>         {},
> --
> 1.7.12
>

Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
