From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 02 Apr 2013 18:39:43 +0900
Subject: [PATCH 2/2] ARM: S3C64XX: Slow down mic detection rate for wm5102
In-Reply-To: <1364469746-5026-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1364469746-5026-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1364469746-5026-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <234901ce2f86$01b22ba0$051682e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> A slightly slower rate provides more reliable jack detection during
> slower insertions.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-
> s3c64xx/mach-crag6410-module.c
> index bf3d1c0..a946b75 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -210,6 +210,7 @@ static struct arizona_pdata wm5102_reva_pdata = {
>  	.gpio_base = CODEC_GPIO_BASE,
>  	.irq_active_high = true,
>  	.micd_pol_gpio = CODEC_GPIO_BASE + 4,
> +	.micd_rate = 6,
>  	.gpio_defaults = {
>  		[2] = 0x10000, /* AIF3TXLRCLK */
>  		[3] = 0x4,     /* OPCLK */
> --
> 1.7.10.4

Applied, thanks.

- Kukjin
