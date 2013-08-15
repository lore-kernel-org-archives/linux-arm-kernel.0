From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 15 Aug 2013 16:41:02 +0100
Subject: [PATCH 1/2] ARM: integrator_cp: Set LCD{0,1} enable lines when
 turning on CLCD
In-Reply-To: <1374594138-17080-2-git-send-email-jonathan.austin@arm.com>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-2-git-send-email-jonathan.austin@arm.com>
Message-ID: <520CF68E.7060504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 23/07/13 16:42, Jonathan Austin wrote:
> This turns on the internal integrator LCD display(s). It seems that the code
> to do this got lost in refactoring of the CLCD driver.
>

Assuming this is okay, should this go through you or the patch system?

Jonny
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> ---
>   arch/arm/mach-integrator/integrator_cp.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
> index 8c60fcb..2f4c9248 100644
> --- a/arch/arm/mach-integrator/integrator_cp.c
> +++ b/arch/arm/mach-integrator/integrator_cp.c
> @@ -199,7 +199,8 @@ static struct mmci_platform_data mmc_data = {
>   static void cp_clcd_enable(struct clcd_fb *fb)
>   {
>   	struct fb_var_screeninfo *var = &fb->fb.var;
> -	u32 val = CM_CTRL_STATIC1 | CM_CTRL_STATIC2;
> +	u32 val = CM_CTRL_STATIC1 | CM_CTRL_STATIC2
> +			| CM_CTRL_LCDEN0 | CM_CTRL_LCDEN1;
>
>   	if (var->bits_per_pixel <= 8 ||
>   	    (var->bits_per_pixel == 16 && var->green.length == 5))
>
