From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Jun 2012 17:50:28 +0900
Subject: [PATCH 1/2] ARM: S3C64XX: Dynamically allocate the IRQ range for
 WM8994 on Cragganmore
In-Reply-To: <1338727361-25243-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1338727361-25243-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <019901cd4df8$934b5bb0$b9e21310$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Use the new irqdomain support in the WM8994 driver to dynamically allocate
> the interrupt range for the WM8994 rather than doing it explicitly. This
> is more idiomatic for modern interrupt usage.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/include/mach/crag6410.h |    1 -
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c  |    1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/crag6410.h
> b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
> index 4cb2f951..ec97c15 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/crag6410.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/crag6410.h
> @@ -15,7 +15,6 @@
> 
>  #define BANFF_PMIC_IRQ_BASE		IRQ_BOARD_START
>  #define GLENFARCLAS_PMIC_IRQ_BASE	(IRQ_BOARD_START + 64)
> -#define CODEC_IRQ_BASE			(IRQ_BOARD_START + 128)
> 
>  #define PCA935X_GPIO_BASE		GPIO_BOARD_START
>  #define CODEC_GPIO_BASE			(GPIO_BOARD_START + 8)
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-
> s3c64xx/mach-crag6410-module.c
> index 4979372..4a83b4e 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -168,7 +168,6 @@ static struct wm8994_pdata wm8994_pdata = {
>  	.gpio_defaults = {
>  		0x3,          /* IRQ out, active high, CMOS */
>  	},
> -	.irq_base = CODEC_IRQ_BASE,
>  	.ldo = {
>  		 { .init_data = &wm8994_ldo1, },
>  		 { .init_data = &wm8994_ldo2, },
> --
> 1.7.10

Yeah, I agree with your comments. Will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
